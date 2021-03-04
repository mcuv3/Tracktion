part of 'routines_bloc.dart';

@immutable
abstract class RoutinesEvent {}

class StreamRoutines extends RoutinesEvent {
  final int groupId;
  StreamRoutines(this.groupId);
}

class SaveRoutine extends RoutinesEvent {
  final RoutineData routine;
  final List<RoutineSetData> sets;
  SaveRoutine(this.routine, this.sets);
}

class DeleteRoutine extends RoutinesEvent {
  final int id;
  DeleteRoutine(this.id);
}
