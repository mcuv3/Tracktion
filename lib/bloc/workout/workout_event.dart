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
  final bool isEdit;
  SaveSet({this.set, this.date, this.isEdit});
}

class DeleteSet extends WorkoutEvent {
  final modelsApp.SetWorkout set;
  DeleteSet(this.set);
}

class DeleteSets extends WorkoutEvent {
  final List<modelsApp.SetWorkout> sets;
  DeleteSets(this.sets);
}

class SaveRep extends WorkoutEvent {
  final modelsApp.Rep rep;

  SaveRep({this.rep});
}

class DeleteRep extends WorkoutEvent {
  final Rep rep;
  DeleteRep(this.rep);
}

class CopySets extends WorkoutEvent {
  final List<modelsApp.SetWorkout> sets;
  final DateTime date;
  final Map<int, dynamic> workoutFilters;
  CopySets(
      {@required this.sets,
      @required this.date,
      @required this.workoutFilters});
}

class CopyRoutine extends WorkoutEvent {
  final List<RoutineSetData> sets;
  CopyRoutine(this.sets);
}
