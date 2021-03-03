part of 'routines_bloc.dart';

@immutable
abstract class RoutinesEvent {}

class StreamRoutines extends RoutinesEvent {}

class SaveRoutines extends RoutinesEvent {
  final List<Routine> routines;

  SaveRoutines(this.routines);
}

class DeleteRoutine extends RoutinesEvent {
  final String id;
  DeleteRoutine(this.id);
}
