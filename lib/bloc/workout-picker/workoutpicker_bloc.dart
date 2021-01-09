import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/app/index.dart' as appModels;
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/util/toDayDate.dart';

part 'workoutpicker_event.dart';
part 'workoutpicker_state.dart';

class WorkoutpickerBloc extends Bloc<WorkoutpickerEvent, WorkoutpickerState> {
  SQLDatabase db;
  WorkoutpickerBloc({this.db}) : super(WorkoutLoading());

  @override
  Stream<WorkoutpickerState> mapEventToState(
    WorkoutpickerEvent event,
  ) async* {
    if (event is PickWorkout) {
      yield* _pickWorkout(event);
    } else if (event is DeleteSetPicker) {
      yield* _deleteSet(event);
    } else {
      yield* _saveRep(event);
    }
  }

  Stream<WorkoutpickerState> _pickWorkout(PickWorkout event) async* {
    yield WorkoutLoading();
    try {
      var date = toDayDate(event.date);
      final sets = await this.db.findSets(date);

      yield Workout(date: date, sets: sets);
    } catch (e) {
      print(e);
      yield WorkoutPickerFailure("Cannot fetch that workout");
    }
  }

  Stream<WorkoutpickerState> _deleteSet(DeleteSetPicker event) async* {
    final sets = [...(state as Workout).sets];
    final prevDate = (state as Workout).date;
    yield WorkoutLoading();

    try {
      sets.removeWhere((element) => element.id == event.setId);
      yield Workout(sets: sets, date: prevDate);
    } catch (e) {
      yield WorkoutPickerFailure("Cannot delete the set");
    }
  }

  Stream<WorkoutpickerState> _saveRep(SaveRepPicker event) async* {
    final sets = [...(state as Workout).sets];
    final prevDate = (state as Workout).date;
    yield WorkoutLoading();
    try {
      sets[event.setIndex].reps[event.repIndex] = event.rep;
      yield Workout(sets: sets, date: prevDate);
    } catch (e) {
      yield WorkoutPickerFailure("Cannot sava the rep");
    }
  }

  Future<List<Map<DateTime, List<int>>>> allWorkouts() {}
}
