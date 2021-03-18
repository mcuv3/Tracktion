part of 'routine_bloc.dart';

@immutable
abstract class RoutineGroupEvent {}

class StreamGroupRoutines extends RoutineGroupEvent {}

class SaveGroupRoutine extends RoutineGroupEvent {
  final RoutineGroupCompanion group;
  SaveGroupRoutine(this.group);
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
