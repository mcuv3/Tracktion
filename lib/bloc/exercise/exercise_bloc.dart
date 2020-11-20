import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/helper/http.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/difficulties.dart';
import 'package:tracktion/models/exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExercisesInitial());

  @override
  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    if (event is FetchExers) {
      yield* _fetchExes(event);
    } else if (event is CreateExe) {
      yield* _createExe(event);
    } else if (event is EditExe) {
      yield* _editExe(event);
    } else if (event is DeleteExe) {
      yield* _deleteExe(event);
    }
  }

  Stream<ExerciseState> _deleteExe(DeleteExe event) async* {
    yield ExercisesLoading();
    try {
      // yield Exercises();
    } catch (e) {}
  }

  Stream<ExerciseState> _editExe(EditExe event) async* {
    yield ExercisesLoading();
    try {
      // yield Exercises();
    } catch (e) {}
  }

  Stream<ExerciseState> _createExe(CreateExe event) async* {
    yield ExercisesLoading();
    try {
      final exe = event.exe;
      final res = await Ht.post('/api/exercise/v1/', body: exe.toJson());
      print(res.body);
      yield ExerciseCreatedSuccess();
    } catch (e) {
      print(e);
      yield ExerciseFailure(
          message: "Cannot create the exercise", statusCode: 400);
    }
  }

  Stream<ExerciseState> _fetchExes(FetchExers event) async* {
    yield ExercisesLoading();
    try {
      final bd = event.bodyPart;
      final res = await Ht.get("/api/exercise/v1/?body_part=$bd");
      final data = Ht.conv(res.body) as List<dynamic>;
      final List<Exercise> exs = [];

      print(data);

      data.forEach((e) {
        exs.add(Exercise(
          id: e["id"],
          name: e['name'],
          difficulty: toDifficulty(e['difficulty']),
          bodyParts: toBodyPart(e["body_part"]),
          notes: e["notes"],
        ));
      });

      yield Exercises(exs);
    } catch (e) {
      print(e);
      yield ExerciseFailure(message: "Something went wrong", statusCode: 400);
    }
  }
}
