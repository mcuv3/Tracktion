part of 'workout_bloc.dart';

@immutable
abstract class WorkoutEvent {}

class FetchWorkout extends WorkoutEvent {
  final DateTime date;
  FetchWorkout(this.date);
}

class DeleteWorkout extends WorkoutEvent {
  final int workoutId;
  DeleteWorkout(this.workoutId);
}

class SaveSet extends WorkoutEvent {
  final modelsApp.Set set;
  SaveSet(this.set);
}

class DeleteSet extends WorkoutEvent {
  final SetWorkout set;
  DeleteSet(this.set);
}

class SaveRep extends WorkoutEvent {
  final Rep rep;
  SaveRep(this.rep);
}

class DeleteRep extends WorkoutEvent {
  final Rep rep;
  DeleteRep(this.rep);
}
