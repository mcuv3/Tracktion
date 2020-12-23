part of 'workout_bloc.dart';

@immutable
abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutSets extends WorkoutState {
  final Stream<List<Set>> sets;
  final DateTime date;
  WorkoutSets({this.sets, this.date});
}

class WorkoutTransactionFailed extends WorkoutState {
  final String message;
  WorkoutTransactionFailed(this.message);
}
