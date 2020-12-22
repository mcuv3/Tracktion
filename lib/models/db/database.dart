import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/difficulties.dart';

import '../app/exercise.dart' as exeApp;
import '../tables/ExercisesModels.dart';

part 'database.g.dart';

@UseMoor(tables: [Exercises, ExerciseBodyParts, Migrations])
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
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

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
            ExerciseBodyPart(bodyPart: bodyPart, exerciseId: exerciseId),
            mode: InsertMode.replace);
      }
    });
  }

  Future<Stream<List<exeApp.Exercise>>> findByBodyPart(BodyPartEnum bd) async {
    final query = select(exercises).join([
      leftOuterJoin(exerciseBodyParts,
          exerciseBodyParts.exerciseId.equalsExp(exercises.id)),
    ]);
    return query.watch().map((row) {
      return row
          .fold<List<exeApp.Exercise>>([], (exes, row) {
            print(row.readTable(exerciseBodyParts));
            final exercise = row.readTable(exercises);
            final exerciseId = row.readTable(exercises).id;
            final bodyPart = row.readTable(exerciseBodyParts).bodyPart;
            final indexExe = exes.indexWhere((exe) => exe.id == exerciseId);
            if (indexExe == -1) {
              exes.add(exeApp.Exercise(
                  id: exercise.id,
                  name: exercise.name,
                  bodyParts: [bodyPart],
                  difficulty: exercise.difficulty,
                  notes: exercise.notes));
            } else {
              exes[indexExe].bodyPartSet = [
                ...exes[indexExe].bodyParts,
                bodyPart
              ];
            }
            return exes;
          })
          .toList()
          .where((exe) {
            // print(exe);
            return exe.bodyParts.contains(bd);
          })
          .toList();
    });
  }

  Future<void> deleteExercise(Exercise exe) async {
    await (delete(exerciseBodyParts)..where((t) => t.exerciseId.equals(exe.id)))
        .go();
    await delete(exercises).delete(exe);
  }

  Future<List<Exercise>> getAllExercises() => select(exercises).get();
  Future<List<Migration>> getAllMigrations() => select(migrations).get();

  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();
  Future insertExercise(Exercise exe) => into(exercises).insert(exe);
  Future insertMigration(MigrationsCompanion migration) =>
      into(migrations).insert(migration);

  Future deleteMigration(Migration migration) =>
      delete(migrations).delete(migration);
  Future updateExercise(Exercise exe) => update(exercises).replace(exe);
  // Future deleteExercise(Exercise exe) => delete(exercises).delete(exe);
}

class ExerciseWithBodyParts {
  final Exercise exe;
  final List<BodyPartEnum> bodyParts;
  ExerciseWithBodyParts({this.exe, this.bodyParts});
}
