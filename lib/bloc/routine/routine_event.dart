part of 'routine_bloc.dart';

@immutable
abstract class RoutineEvent {}

class StreamRoutine extends RoutineEvent {
  final int routineId;
  StreamRoutine(this.routineId);
}

class SaveRoutineMetadata extends RoutineEvent {
  final String name;
  final String description;
  SaveRoutineMetadata({this.name, this.description});
}

class DeleteSet extends RoutineEvent {}

class SaveSet extends RoutineEvent {}

class DeleteRep extends RoutineEvent {}

class SaveRep extends RoutineEvent {}
