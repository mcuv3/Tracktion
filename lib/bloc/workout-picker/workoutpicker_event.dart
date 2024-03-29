part of 'workoutpicker_bloc.dart';

@immutable
abstract class WorkoutpickerEvent {}

class PickWorkout extends WorkoutpickerEvent {
  final DateTime date;
  PickWorkout(this.date);
}

class ResetWorkoutCalendar extends WorkoutpickerEvent {}

class RestoreWorkoutCalendar extends WorkoutpickerEvent {}

class FetchWorkoutByDate extends WorkoutpickerEvent {
  final DateTime start;
  final DateTime end;
  FetchWorkoutByDate(this.start, this.end);
}

class FetchWorkoutExercises extends WorkoutpickerEvent {
  final int workoutId;
  FetchWorkoutExercises(this.workoutId);
}

class DeleteSetPicker extends WorkoutpickerEvent {
  final int setId;
  DeleteSetPicker(this.setId);
}

class SaveRepPicker extends WorkoutpickerEvent {
  final appModels.Rep rep;
  final int setIndex;
  final int repIndex;

  SaveRepPicker({this.rep, this.setIndex, this.repIndex});
}
