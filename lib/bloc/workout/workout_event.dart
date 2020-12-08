part of 'workout_bloc.dart';

@immutable
abstract class WorkoutEvent {}

class FetchWorkout extends WorkoutEvent {
  final DateTime date;
  FetchWorkout(this.date);
}
