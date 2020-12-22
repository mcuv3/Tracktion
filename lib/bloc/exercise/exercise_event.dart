part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseEvent {}

class FetchExers extends ExerciseEvent {
  final BodyPartEnum bodyPart;
  FetchExers(this.bodyPart);
}

class CreateExe extends ExerciseEvent {
  final exeModel.Exercise exe;
  CreateExe(this.exe);
}

class EditExe extends ExerciseEvent {
  final exeModel.Exercise exe;
  EditExe(this.exe);
}

class DeleteExe extends ExerciseEvent {
  final exeModel.Exercise exe;
  DeleteExe(this.exe);
}
