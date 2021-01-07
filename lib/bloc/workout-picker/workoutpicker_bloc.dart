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

  Future<List<Map<DateTime, List<int>>>> allWorkouts() {}
}
