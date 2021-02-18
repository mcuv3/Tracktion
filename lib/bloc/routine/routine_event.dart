part of 'routine_bloc.dart';

@immutable
abstract class RoutineEvent {}

class StreamRoutines extends RoutineEvent {
  final int groupId;
  StreamRoutines(this.groupId);
}

class StreamGroupRoutines extends RoutineEvent {}

class CreateRoutine extends RoutineEvent {
  final Routine routine;
  CreateRoutine(this.routine);
}

class CreateGroupRoutine extends RoutineEvent {
  final List<Routine> routines;
  final String name;
  final String description;
  CreateGroupRoutine({this.routines, this.name, this.description});
}

class EditRoutine extends RoutineEvent {
  final Routine routine;
  EditRoutine(this.routine);
}

class DeleteRoutine extends RoutineEvent {
  final Routine routine;
  DeleteRoutine(this.routine);
}

class DeleteGroupRoutine extends RoutineEvent {
  final int groupId;
  final Map<int, List<int>> routines;
  DeleteGroupRoutine({this.routines, this.groupId});
}
