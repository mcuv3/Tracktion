import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/bloc/common/Workout.dart';
import 'package:tracktion/util/toDayDate.dart';

import '../../models/app/index.dart' as modelsApp;
import '../../models/db/database.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final SQLDatabase db;
  final Common common;
  WorkoutBloc({@required this.db, @required this.common})
      : super(WorkoutInitial());

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
    DateTime date = toDayDate(DateTime.now());
    if (event.date == null && state is WorkoutSets) {
      date = (state as WorkoutSets).date;
    } else if (event.date != null) date = toDayDate(event.date);
    yield WorkoutLoading();
    try {
      final sets = this.db.findSetsByDate(date);
      yield WorkoutSets(sets: sets, date: date);
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
    try {
      final workout = await this.db.findOrCreateWorkout(event.date);
      final set = event.set;
      final reps = set.reps;
      final exerciseSet = ExerciseSet(
        id: set.id,
        exeId: set.exercise.id,
        workoutId: workout.id,
        reps: reps,
      );
      await this.db.saveSet(exerciseSet);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveRep(SaveRep event) async {
    try {
      print(event.rep.setId);

      final rep = Rep(
          id: event.rep.id,
          note: event.rep.notes,
          weight: event.rep.weight,
          reps: event.rep.reps,
          rpe: event.rep.rpe,
          setId: event.rep.setId);
      await this.db.saveRep(rep);
    } catch (e) {
      print(e);
    }
  }
}
