import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/difficulties.dart';
import './exercise/ExercisesModels.dart';
import './exercise.dart' as exeApp;

part 'database.g.dart';

@UseMoor(tables: [Exercises, ExerciseBodyParts])
class SQLDatabase extends _$SQLDatabase {
  // we tell the database where to store the data with this constructor
  SQLDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "tracktion.sqlite",
            logStatements: false,
            singleInstance: true));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // for (final bd in BodyPartEnum.values) {
        //   await into(bodyParts).insert(BodyPart(bodyPartInt: bd));
        // }
        return;
      },
      onUpgrade: (Migrator m, int from, int to) async {});

  Future<void> saveExercise(ExerciseWithBodyParts entry) {
    return transaction(() async {
      final exe = entry.exe;
      final exerciseId =
          await into(exercises).insert(exe, mode: InsertMode.replace);
      await (delete(exerciseBodyParts)
            ..where((entry) => entry.exerciseId.equals(exerciseId)))
          .go();
      for (final bodyPart in entry.bodyParts) {
        await into(exerciseBodyParts).insert(
            ExerciseBodyPart(bodyPart: bodyPart, exerciseId: exerciseId));
      }
    });
  }

  Future<List<exeApp.Exercise>> findByBodyPart(BodyPartEnum bd) async {
    List<TypedResult> query = await select(exercises).join([
      leftOuterJoin(exerciseBodyParts,
          exerciseBodyParts.exerciseId.equalsExp(exercises.id)),
    ]).get();

    Map<String, List<BodyPartEnum>> mapBodyParts = {};
    List<exeApp.Exercise> exes = [];

    query.map((row) {
      final exercise = row.readTable(exercises);
      final exerciseId = row.readTable(exercises).id.toString();

      var previousBodyParts = mapBodyParts[exerciseId];
      if (previousBodyParts == null) {
        exes.add(exeApp.Exercise(
            id: exercise.id,
            name: exercise.name,
            bodyParts: [],
            difficulty: exercise.difficulty,
            notes: exercise.notes));
        previousBodyParts = [];
      }

      mapBodyParts[exerciseId] = [
        ...previousBodyParts,
        row.readTable(exerciseBodyParts).bodyPart
      ];
      return exercise;
    }).toList();

    return exes.map((exe) {
      exe.bodyPartss = mapBodyParts[exe.id.toString()];
      return exe;
    }).toList();

    // return data;

    // return data.where((d) => d.bodyPart.bodyPartInt == bd);
  }

  Future<List<Exercise>> getAllExercises() => select(exercises).get();
  // Stream<List<Exercise>> watchAllExercises() => select(Exercises).watch();
  Future insertExercise(Exercise exe) => into(exercises).insert(exe);
  Future updateExercise(Exercise exe) => update(exercises).replace(exe);
  Future deleteExercise(Exercise exe) => delete(exercises).delete(exe);
}

class ExerciseWithBodyParts {
  final Exercise exe;
  final List<BodyPartEnum> bodyParts;
  ExerciseWithBodyParts({this.exe, this.bodyParts});
}

// class ExerciseFull {
//   final Exercise exe;
//   final List<> bodyPart;

//   set bodyParts(BodyParts){}

//   ExerciseFull(this.exe, this.bodyPart);
// }
