part of 'routines_bloc.dart';

@immutable
abstract class RoutinesEvent {}

class StreamRoutines extends RoutinesEvent {
  final int groupId;
  StreamRoutines(this.groupId);
}

class FetchRoutines extends RoutinesEvent {}

class FilterRoutines extends RoutinesEvent {
  final List<bool> filters;
  final String search;
  FilterRoutines(this.filters, this.search);
}

class SaveFullRoutine extends RoutinesEvent {
  final RoutineData routine;
  final List<RoutineSetData> sets;
  SaveFullRoutine(this.routine, this.sets);
}

class SaveRoutine extends RoutinesEvent {
  final RoutineData routine;
  SaveRoutine(this.routine);
}

class DeleteRoutine extends RoutinesEvent {
  final int id;
  DeleteRoutine(this.id);
}
