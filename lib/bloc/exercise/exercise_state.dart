part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState {}

class ExercisesLoading extends ExerciseState {}

class ExercisesInitial extends ExerciseState {}

class Exercises extends ExerciseState {
  final List<Exercise> exs;
  Exercises(this.exs);
}

class ExerciseFailure extends ExerciseState {
  final String message;
  final num statusCode;

  ExerciseFailure({this.message, this.statusCode});
}

class ExerciseCreatedSuccess extends ExerciseState {}
