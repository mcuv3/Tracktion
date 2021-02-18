part of 'routine_bloc.dart';

@immutable
abstract class RoutineState {}

class RoutinesLoading extends RoutineState {}

class RoutinesInitial extends RoutineState {}

class Routines extends RoutineState {
  final Stream<List<Routine>> routines;
  Routines(this.routines);
}

class RoutineFailure extends RoutineState {
  final String message;

  RoutineFailure(this.message);
}

class RoutineDeleteSuccess extends RoutineState {}

class RoutineCreatedSuccess extends RoutineState {}
