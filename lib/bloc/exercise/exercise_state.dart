part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState {}

class ExercisesLoading extends ExerciseState {}

class ExercisesInitial extends ExerciseState {}

class AllExercises extends ExerciseState {
  final List<exeApp.Exercise> exes;
  AllExercises(this.exes);
}

class Exercises extends ExerciseState {
  // final List<exeModel.Exercise> exs;
  // Exercises(this.exs);
  final Stream<List<exeApp.Exercise>> exes;
  Exercises(this.exes);
}

class ExerciseFailure extends ExerciseState {
  final String message;
  final num statusCode;

  ExerciseFailure({@required this.message, @required this.statusCode});
}

class ExerciseDeleteSuccess extends ExerciseState {}

class ExerciseCreatedSuccess extends ExerciseState {}
