part of 'routine_bloc.dart';

@immutable
abstract class RoutineEvent {}

class StreamRoutine extends RoutineEvent {
  final int routineId;
  StreamRoutine(this.routineId);
}

class DeleteSet extends RoutineEvent {
  final int setId;
  DeleteSet(this.setId);
}

class SaveSet extends RoutineEvent {
  final RoutineSetData set;
  SaveSet(this.set);
}
