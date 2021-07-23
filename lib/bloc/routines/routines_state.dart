part of 'routines_bloc.dart';

@immutable
abstract class RoutinesState {}

class RoutinesLoading extends RoutinesState {}

class Routines extends RoutinesState {
  final Stream<List<RoutineData>> routines;
  Routines(this.routines);
}

class RoutinesSuccess extends RoutinesState {}

class RoutinesFailure extends RoutinesState {
  final String message;
  RoutinesFailure(this.message);
}
