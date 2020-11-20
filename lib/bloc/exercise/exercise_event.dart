part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseEvent {}

class FetchExers extends ExerciseEvent {
  final String bodyPart;
  FetchExers(this.bodyPart);
}

class CreateExe extends ExerciseEvent {
  final Exercise exe;
  CreateExe(this.exe);
}

class EditExe extends ExerciseEvent {
  final Exercise exe;
  EditExe(this.exe);
}

class DeleteExe extends ExerciseEvent {
  final String exeId;
  DeleteExe(this.exeId);
}
