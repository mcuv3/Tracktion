part of 'exercisestream_cubit.dart';

@immutable
abstract class ExerciseStreamState {}

class ExerciseStreamInitial extends ExerciseStreamState {}


class ExeStream extends ExerciseStreamState {

  final Stream<modelsApp.Exercise?> exe;
  ExeStream(this.exe);

}