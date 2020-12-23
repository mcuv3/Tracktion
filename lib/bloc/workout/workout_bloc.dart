import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/db/database.dart';
import '../../models/app/index.dart' as modelsApp;

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final SQLDatabase db;
  WorkoutBloc({this.db}) : super(WorkoutInitial());

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    if (event is FetchWorkout) {
      yield* _fetchWorkout(event);
    } else if (event is DeleteWorkout) {
      yield* _deleteWorkout(event);
    } else if (event is DeleteSet) {
      _deleteSet(event);
    } else if (event is DeleteRep) {
      _deleteRep(event);
    } else if (event is SaveRep) {
      _saveRep(event);
    } else if (event is SaveSet) {
      _saveSet(event);
    }
  }

  Stream<WorkoutState> _fetchWorkout(FetchWorkout event) async* {
    yield WorkoutLoading();
    try {
      final date = event.date;
      await Future.delayed(Duration(seconds: 3));
      yield WorkoutInitial();
    } catch (e) {
      yield WorkoutTransactionFailed("Cannot fetch this workout");
    }
  }

  Stream<WorkoutState> _deleteWorkout(DeleteWorkout event) async* {
    yield WorkoutLoading();
    try {
      await this.db.deleteWorkout(event.workoutId);
    } catch (e) {}
  }

  Future<void> _deleteSet(DeleteSet event) async {
    try {
      await this.db.deleteSet(event.set);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteRep(DeleteRep event) async {
    try {
      await this.db.deleteRep(event.rep);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveSet(SaveSet event) async {
    if (state is WorkoutSets) {
      try {
        final currentDate = (state as WorkoutSets).date;
        final workout = await this.db.findOrCreateWorkout(currentDate);
        final set = event.set;
        final reps = set.reps;
        final exerciseSet = ExerciseSet(
            exeId: set.exercise.id, workoutId: workout.id, reps: reps);
        await this.db.saveSet(exerciseSet);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _saveRep(SaveRep event) async {
    try {
      await this.db.saveRep(event.rep);
    } catch (e) {
      print(e);
    }
  }
}