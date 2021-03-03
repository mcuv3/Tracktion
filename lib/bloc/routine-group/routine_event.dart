part of 'routine_bloc.dart';

@immutable
abstract class RoutineGroupEvent {}

class StreamGroupRoutines extends RoutineGroupEvent {}

class SaveGroupRoutine extends RoutineGroupEvent {
  final String name;
  final String description;
  SaveGroupRoutine({this.name, this.description});
}

class DeleteGroupRoutine extends RoutineGroupEvent {
  final int groupId;
  DeleteGroupRoutine(this.groupId);
}

// class DeleteGroupRoutine extends RoutineGroupEvent {
//   final int groupId;
//   final Map<int, List<int>> routines;
//   DeleteGroupRoutine({this.routines, this.groupId});
// }
