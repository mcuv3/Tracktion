part of 'workoutpicker_bloc.dart';

@immutable
abstract class WorkoutpickerEvent {}

class PickWorkout extends WorkoutpickerEvent {
  final DateTime date;
  PickWorkout(this.date);
}

class DeleteSet extends WorkoutpickerEvent {
  final int setId;
  DeleteSet(this.setId);
}

class SaveRep extends WorkoutpickerEvent {
  final appModels.Rep rep;
  final int setIndex;
  final int repIndex;

  SaveRep({this.rep, this.setIndex, this.repIndex});
}
