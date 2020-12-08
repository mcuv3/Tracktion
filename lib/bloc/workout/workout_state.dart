part of 'workout_bloc.dart';

@immutable
abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutFailed extends WorkoutState {
  final String message;
  WorkoutFailed(this.message);
}
