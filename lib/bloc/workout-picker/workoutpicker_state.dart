part of 'workoutpicker_bloc.dart';

@immutable
abstract class WorkoutpickerState {}

class WorkoutLoading extends WorkoutpickerState {}

class Workout extends WorkoutpickerState {
  final List<appModels.SetWorkout> sets;
  final DateTime date;
  Workout({this.sets, this.date});
}

class WorkoutPickerFailure extends WorkoutpickerState {
  final String message;
  WorkoutPickerFailure(this.message);
}
