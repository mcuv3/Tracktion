part of 'routine_bloc.dart';

@immutable
abstract class RoutineState {}

class RoutineLoading extends RoutineState {}

class Routine extends RoutineState {
  final Stream<List<RoutineSetData>> routine;
  Routine(this.routine);
}

class RoutineSuccess extends RoutineState {}

class RoutineFailure extends RoutineState {
  final String message;
  RoutineFailure(this.message);
}
