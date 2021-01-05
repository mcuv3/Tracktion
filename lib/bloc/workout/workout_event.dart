part of 'workout_bloc.dart';

@immutable
abstract class WorkoutEvent {}

class FetchWorkout extends WorkoutEvent {
  final DateTime date;
  FetchWorkout({this.date});
}

class DeleteWorkout extends WorkoutEvent {
  final int workoutId;
  DeleteWorkout(this.workoutId);
}

class SaveSet extends WorkoutEvent {
  final modelsApp.SetWorkout set;
  final DateTime date;
  SaveSet({this.set, this.date});
}

class DeleteSet extends WorkoutEvent {
  final int setId;
  DeleteSet(this.setId);
}

class DeleteSets extends WorkoutEvent {
  final List<int> setsId;
  DeleteSets(this.setsId);
}

class SaveRep extends WorkoutEvent {
  final modelsApp.Rep rep;

  SaveRep({this.rep});
}

class DeleteRep extends WorkoutEvent {
  final Rep rep;
  DeleteRep(this.rep);
}
