import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/difficulties.dart';
import 'package:tracktion/models/tables/WorkOut.dart';

import '../app/exercise.dart' as exeApp;
import '../app/index.dart' as modelsApp;
import '../tables/Exercise.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Exercises,
  ExerciseBodyParts,
  Migrations,
  SetWorkouts,
  Workouts,
  Reps
])
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
        print(bodyPart);
        await into(exerciseBodyParts).insert(
            ExerciseBodyPart(bodyPart: bodyPart, exerciseId: exerciseId),
            mode: InsertMode.replace);
      }
    });
  }

  Future<void> deleteSet(SetWorkout setWorkout) {
    return transaction(() async {
      await (delete(reps)..where((e) => e.setId.equals(setWorkout.id))).go();
      await delete(setWorkouts).delete(setWorkout);
    });
  }

  Future<void> saveSet(ExerciseSet exerciseSet) {
    return transaction(() async {
      final exeId = exerciseSet.exeId;
      final workoutId = exerciseSet.workoutId;
      final repsSet = exerciseSet.reps;
      final setId = await into(setWorkouts).insert(
          SetWorkoutsCompanion.insert(workOutId: workoutId, exerciseId: exeId),
          mode: InsertMode.replace);
      await (delete(reps)..where((entry) => entry.setId.equals(setId))).go();
      for (final rep in repsSet) {
        await into(reps).insert(
            RepsCompanion.insert(
                reps: rep.reps, weight: rep.weight, rpe: rep.rpe, setId: setId),
            mode: InsertMode.replace);
      }
    });
  }

  Stream<List<modelsApp.SetWorkout>> findSetsByDate(DateTime targetDate) {
    final query = select(setWorkouts).join([
      innerJoin(workouts, workouts.id.equalsExp(setWorkouts.workOutId)),
      innerJoin(exercises, exercises.id.equalsExp(setWorkouts.exerciseId)),
      innerJoin(reps, reps.setId.equalsExp(setWorkouts.id)),
    ])
      ..where(workouts.date.equals(targetDate));

    return query.watch().map((row) {
      return row.fold<List<modelsApp.SetWorkout>>([], (sets, st) {
        final setWk = st.readTable(setWorkouts);
        final rep = st.readTable(reps);
        final indexSet = sets.indexWhere((st) => st.id == setWk.id);
        final repetition = modelsApp.Rep(
            id: rep.id, weight: rep.weight, reps: rep.reps, rpe: rep.rpe);

        if (indexSet == -1) {
          final exe = st.readTable(exercises);
          final exercise = modelsApp.Exercise(
              id: exe.id,
              name: exe.name,
              difficulty: exe.difficulty,
              notes: exe.notes,
              bodyParts: []);
          sets.add(modelsApp.SetWorkout(
              id: setWk.id, exercise: exercise, reps: [repetition]));
        } else {
          sets[indexSet].reps = [...sets[indexSet].reps, repetition];
        }
        return sets;
      });
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
          .where((exe) => exe.bodyParts.contains(bd))
          .toList();
    });
  }

  Future<Workout> findOrCreateWorkout(DateTime date) async {
    return transaction(() async {
      final shortDate = DateTime(date.year, date.month, date.day);

      final wk = await (select(workouts)
            ..where((e) => e.date.equals(shortDate)))
          .get();

      if (wk.length > 0) return wk[0];

      final workout = WorkoutsCompanion.insert(date: shortDate);
      final workoutId = await into(workouts).insert(workout);

      return Workout(id: workoutId, date: shortDate);
    });
  }

  // COMPLEX DELETES

  Future<void> deleteExercise(Exercise exe) async {
    await (delete(exerciseBodyParts)..where((t) => t.exerciseId.equals(exe.id)))
        .go();
    await delete(exercises).delete(exe);
  }

  Future<void> deleteWorkout(int workoutId) {
    return transaction(() async {
      final sts = await (select(setWorkouts)
            ..where((e) => e.workOutId.equals(workoutId)))
          .get();
      for (final st in sts) {
        await (delete(reps)..where((e) => e.setId.equals(st.id))).go();
      }
      await (delete(workouts)..where((e) => e.id.equals(workoutId))).go();
    });
  }

  // Basics Querys

  Future<List<Exercise>> getAllExercises() => select(exercises).get();
  Future<List<Workout>> getAllWorkouts() => select(workouts).get();
  Future<List<Migration>> getAllMigrations() => select(migrations).get();
  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();
  Future insertMigration(MigrationsCompanion migration) =>
      into(migrations).insert(migration);
  Future deleteMigration(Migration migration) =>
      delete(migrations).delete(migration);
  Future saveRep(Rep rep) => into(reps).insert(rep, mode: InsertMode.replace);
  Future deleteRep(Rep rep) => delete(reps).delete(rep);

  Future<int> saveWorkOut(WorkoutsCompanion wk) =>
      into(workouts).insert(wk, mode: InsertMode.replace);
}

class ExerciseWithBodyParts {
  final Exercise exe;
  final List<BodyPartEnum> bodyParts;
  ExerciseWithBodyParts({this.exe, this.bodyParts});
}

class ExerciseSet {
  final int exeId;
  final int workoutId;
  final List<modelsApp.Rep> reps;
  ExerciseSet({this.exeId, this.reps, this.workoutId});
}
