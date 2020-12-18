import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/helper/http.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/database.dart';
import 'package:tracktion/models/difficulties.dart';
import 'package:tracktion/models/exercise.dart' as exeModel;
import '../../models/exercise.dart' as exeApp;
import 'package:tracktion/util/enumToString.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final SQLDatabase db;

  ExerciseBloc({@required this.db}) : super(ExercisesInitial());

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
    final streamExes = (state as Exercises).exes;
    yield ExercisesLoading();
    try {
      // final exe = event.exe;
      // final res =
      //     await Ht.put('/api/exercise/v1/${exe.id}/', body: exe.toJson());
      // print(res.body);

      final exe = event.exe;
      final exeDb = Exercise(
          id: exe.id,
          difficulty: exe.difficulty,
          name: exe.name,
          notes: exe.notes);
      final exeWithBd =
          ExerciseWithBodyParts(bodyParts: exe.bodyParts, exe: exeDb);
      await db.saveExercise(exeWithBd);
      yield ExerciseCreatedSuccess();
      yield Exercises(streamExes);
    } catch (e) {
      print(e);
      yield ExerciseFailure(
          message: "Cannot edit the exercise", statusCode: 400);
    }
  }

  Stream<ExerciseState> _createExe(CreateExe event) async* {
    yield ExercisesLoading();
    try {
      final exe = event.exe;

      final exeDb = Exercise(
          difficulty: exe.difficulty, name: exe.name, notes: exe.notes);
      final exeWithBd =
          ExerciseWithBodyParts(bodyParts: exe.bodyParts, exe: exeDb);
      await db.saveExercise(exeWithBd);
      // final res = await Ht.post('/api/exercise/v1/', body: exe.toJson());
      // print(res.body);
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
      final dataSql = await db.findByBodyPart(event.bodyPart);
      yield Exercises(dataSql);
    } catch (e) {
      print(e);
      yield ExerciseFailure(message: "Something went wrong", statusCode: 400);
    }
  }
}

// fetch exes
// final bodyPartUperCased = enumToString(event.bodyPart).toUpperCase();
// final res =
//     await Ht.get("/api/exercise/v1/?body_part=$bodyPartUperCased");
// final data = Ht.conv(res.body) as List<dynamic>;
// final List<exeModel.Exercise> exs = [];
// data.forEach((e) {
//   exs.add(exeModel.Exercise(
//     id: e["id"],
//     name: e['name'],
//     difficulty: toDifficulty(e['difficulty']),
//     bodyParts: toBodyPart(e["body_part"]),
//     notes: e["notes"],
//   ));
// });
