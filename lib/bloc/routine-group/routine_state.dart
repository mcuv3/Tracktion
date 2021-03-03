part of 'routine_bloc.dart';

@immutable
abstract class RoutineGroupState {}

class RoutinesLoading extends RoutineGroupState {}

class RoutineGroups extends RoutineGroupState {
  final Stream<List<RoutineGroup>> groups;
  RoutineGroups(this.groups);
}

class RoutineGroupFailure extends RoutineGroupState {
  final String message;
  RoutineGroupFailure(this.message);
}

class RoutinesGroupSuccess extends RoutineGroupState {}
