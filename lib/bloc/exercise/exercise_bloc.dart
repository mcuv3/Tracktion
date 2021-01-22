import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/bloc/common/Workout.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/exercise.dart' as exeModel;
import 'package:tracktion/models/db/database.dart';

import '../../models/app/exercise.dart' as exeApp;

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final SQLDatabase db;
  final Common common;

  ExerciseBloc({@required this.db, @required this.common})
      : super(ExercisesInitial());

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
    final exes = (state as Exercises).exes;
    yield ExercisesLoading();
    try {
      final exe = event.exe;
      final exeEntity = Exercise(
          id: exe.id,
          difficulty: exe.difficulty,
          name: exe.name,
          notes: exe.notes,
          lastWorkouts: exe.lastWorkoutsToString(),
          maxVolume: exe.maxVolume,
          maxWeigth: exe.maxWeigth);

      await db.deleteExercise(exeEntity);

      yield ExerciseDeleteSuccess();
      yield Exercises(exes);
    } catch (e) {
      print(e);
      yield ExerciseFailure(
          message: "Cannot delete de exercise.", statusCode: 400);
      yield Exercises(exes);
    }
  }

  Stream<ExerciseState> _editExe(EditExe event) async* {
    final streamExes = (state as Exercises).exes;
    yield ExercisesLoading();
    try {
      final exe = event.exe;
      final exeDb = Exercise(
          id: exe.id,
          difficulty: exe.difficulty,
          name: exe.name,
          notes: exe.notes,
          lastWorkouts: exe.lastWorkoutsToString(),
          maxVolume: exe.maxVolume,
          maxWeigth: exe.maxWeigth);

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

      await db.insertMigration(MigrationsCompanion.insert(
          verb: "post", endPoint: '/api/exercise/v1/', payload: exe.toJson()));

      final exeDb = Exercise(
          id: exe.id,
          difficulty: exe.difficulty,
          name: exe.name,
          notes: exe.notes,
          lastWorkouts: exe.lastWorkoutsToString(),
          maxVolume: exe.maxVolume,
          maxWeigth: exe.maxWeigth);
      final exeWithBd =
          ExerciseWithBodyParts(bodyParts: exe.bodyParts, exe: exeDb);
      await db.saveExercise(exeWithBd);
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
