part of 'workoutpicker_bloc.dart';

@immutable
abstract class WorkoutpickerEvent {}

class PickWorkout extends WorkoutpickerEvent {
  final DateTime date;
  PickWorkout(this.date);
}

class DeleteSetPicker extends WorkoutpickerEvent {
  final int setId;
  DeleteSetPicker(this.setId);
}

class SaveRepPicker extends WorkoutpickerEvent {
  final appModels.Rep rep;
  final int setIndex;
  final int repIndex;

  SaveRepPicker(
      {required this.rep, required this.setIndex, required this.repIndex});
}
