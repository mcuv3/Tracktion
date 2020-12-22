part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState {}

class ExercisesLoading extends ExerciseState {}

class ExercisesInitial extends ExerciseState {}

class Exercises extends ExerciseState {
  // final List<exeModel.Exercise> exs;
  // Exercises(this.exs);
  final Stream<List<exeApp.Exercise>> exes;
  Exercises(this.exes);
}

class ExerciseFailure extends ExerciseState {
  final String message;
  final num statusCode;

  ExerciseFailure({@required this.message,@required this.statusCode});
}

class ExerciseStream extends ExerciseState {
  final Stream<Exercise> exes;
  ExerciseStream(this.exes);
}

class ExerciseDeleteSuccess extends ExerciseState {}

class ExerciseCreatedSuccess extends ExerciseState {}
