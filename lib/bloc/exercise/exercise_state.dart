part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState {}

class ExercisesLoading extends ExerciseState {}

class ExercisesInitial extends ExerciseState {}

class Exercises extends ExerciseState {
  final List<Exercise> exerceies;
  Exercises(this.exerceies);
}

class ExerciseFailure extends ExerciseState {
  final String message;
  final num statusCode;

  ExerciseFailure({this.message, this.statusCode});
}
