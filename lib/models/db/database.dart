import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/app/RoutineSlim.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/db/migration.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/models/tables/WorkOut.dart';

import '../app/exercise.dart' as exeApp;
import '../app/index.dart' as modelsApp;
import "../tables/Converts.dart";
import '../tables/Exercise.dart';

export 'instance/shared.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Exercises,
  ExerciseBodyParts,
  Migrations,
  SetWorkouts,
  Workouts,
  Reps,
  RoutineGroup,
  Routine,
  RoutineSet,
])
class SQLDatabase extends _$SQLDatabase {
  // SQLDatabase()
  //     : super(kIsWeb ? WebDatabase('tracktionDb'): FlutterQueryExecutor.inDatabaseFolder(
  //           path: "tracktion.sqlite",
  //           logStatements: false,
  //           singleInstance: true));
  SQLDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) async {
        print("Creating database");
        await m.createAll();
        return;
      }, onUpgrade: (Migrator m, int from, int to) async {
        print("Updating database");
        await m.createAll();
      }, beforeOpen: (details) async {
        if (!details.wasCreated) return;

        final exes = exercisesMigration.map((e) => into(exercises).insert(e));
        final bds =
            bodyPartsMigration.map((e) => into(exerciseBodyParts).insert(e));

        await Future.wait(exes);
        await Future.wait(bds);
      });

  Stream<modelsApp.Exercise> findExerciseStream(int exerciseId) {
    final query = select(exercises).join([
      leftOuterJoin(exerciseBodyParts,
          exerciseBodyParts.exerciseId.equalsExp(exercises.id)),
    ])
      ..where(exercises.id.equals(exerciseId));

    return query.watch().map((row) {
      try {
        return row.fold<List<exeApp.Exercise>>([], (exes, row) {
          final exercise = row.readTable(exercises);
          final bodyPart = row.readTable(exerciseBodyParts).bodyPart;
          return mergeTableExercise(exercise, bodyPart, exes);
        }).first;
      } catch (e) {
        return null;
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
      return row.fold<List<modelsApp.SetWorkout>>(
          [], (sets, st) => _mergeExerciseSetWorkout(sets, st));
    });
  }

  Stream<List<RoutineGroupData>> findRoutineGroups() =>
      select(routineGroup).watch();

  // Stream<List<RoutineData>> findRoutines(int groupId) =>
  //     (select(routine)..where((t) => t.groupId.equals(groupId))).watch();
  //

  Future<List<RoutineSlim>> findRoutines([String cursor = ""]) async {
    final res = await (select(routine).join([
      leftOuterJoin(routineGroup, routineGroup.id.equalsExp(routine.groupId))
    ])
          ..orderBy([OrderingTerm(expression: routine.timesCopied)]))
        .get();

    return res.map((row) {
      final group = row.readTable(routineGroup);
      final rt = row.readTable(routine);
      return RoutineSlim(
          id: rt.id,
          difficulty: rt.difficulty,
          groupName: group.name,
          routineName: rt.name,
          topBodyParts: rt.bodyParts);
    }).toList();
  }

  Stream<List<modelsApp.RoutineDay>> findRoutinesByGroup(int groupId) {
    final query = select(routine).join(
        [leftOuterJoin(routineSet, routineSet.routineId.equalsExp(routine.id))])
      ..where(routine.groupId.equals(groupId));

    return query.watch().map((row) {
      return row.fold<List<modelsApp.RoutineDay>>([], (routineDays, tuple) {
        final _routine = tuple.readTable(routine);
        final set = tuple.readTableOrNull(routineSet);
        final indexRoutine =
            routineDays.indexWhere((r) => r.routine.id == _routine.id);

        if (indexRoutine == -1)
          routineDays.add(modelsApp.RoutineDay(
              routine: _routine, sets: set != null ? [set] : []));
        else
          routineDays[indexRoutine].add(set);

        return routineDays;
      });
    });
  }

  Stream<List<RoutineSetData>> findRoutinesSet(int routineId) =>
      (select(routineSet)..where((t) => t.routineId.equals(routineId))).watch();

  Future<List<modelsApp.SetWorkout>> findSets(DateTime targetDate) async {
    final query = select(setWorkouts).join([
      innerJoin(workouts, workouts.id.equalsExp(setWorkouts.workOutId)),
      innerJoin(exercises, exercises.id.equalsExp(setWorkouts.exerciseId)),
      innerJoin(reps, reps.setId.equalsExp(setWorkouts.id)),
    ])
      ..where(workouts.date.equals(targetDate));
    final data = await query.get();

    return data.fold<List<modelsApp.SetWorkout>>(
        [], (sets, st) => _mergeExerciseSetWorkout(sets, st));
  }

  List<modelsApp.SetWorkout> _mergeExerciseSetWorkout(
      List<modelsApp.SetWorkout> _sets, TypedResult st) {
    final sets = [..._sets];
    final setWk = st.readTable(setWorkouts);
    final rep = st.readTable(reps);
    final indexSet = sets.indexWhere((st) => st.id == setWk.id);
    final repetition = modelsApp.Rep(
        id: rep.id,
        weight: rep.weight,
        reps: rep.reps,
        rpe: rep.rpe,
        notes: rep.note);

    if (indexSet == -1) {
      final exe = st.readTable(exercises);
      final exercise = modelsApp.Exercise(
          id: exe.id,
          maxVolumeSetId: exe.maxVolumeSetId,
          maxWeigthSetId: exe.maxWeigthSetId,
          lastWorkouts:
              modelsApp.Exercise.stringToLastWorkouts(exe.lastWorkouts),
          maxVolume: exe.maxVolume,
          maxWeigth: exe.maxWeigth,
          name: exe.name,
          difficulty: exe.difficulty,
          notes: exe.notes,
          bodyParts: []);
      sets.add(modelsApp.SetWorkout(
          id: setWk.id,
          exercise: exercise,
          reps: [repetition],
          maxWeigth: setWk.maxWeigth,
          volume: setWk.volume));
    } else {
      sets[indexSet].reps = [...sets[indexSet].reps, repetition];
    }
    return sets;
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
            final bodyPart = row.readTable(exerciseBodyParts).bodyPart;
            return mergeTableExercise(exercise, bodyPart, exes);
          })
          .toList()
          .where((exe) => exe.bodyParts.contains(bd))
          .toList();
    });
  }

  List<exeApp.Exercise> mergeTableExercise(
      Exercise exercise, BodyPartEnum bodyPart, List<exeApp.Exercise> exs) {
    final exes = [...exs];

    final indexExe = exes.indexWhere((exe) => exe.id == exercise.id);
    if (indexExe == -1)
      exes.add(exeApp.Exercise(
          id: exercise.id,
          maxVolumeSetId: exercise.maxVolumeSetId,
          maxWeigthSetId: exercise.maxWeigthSetId,
          lastWorkouts:
              modelsApp.Exercise.stringToLastWorkouts(exercise.lastWorkouts),
          maxVolume: exercise.maxVolume,
          maxWeigth: exercise.maxWeigth,
          name: exercise.name,
          bodyParts: [bodyPart],
          difficulty: exercise.difficulty,
          notes: exercise.notes));
    else
      exes[indexExe].bodyPartSet = [...exes[indexExe].bodyParts, bodyPart];

    return exes;
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

  Future<List> findMaxVolume(int exerciseId, int setId) async {
    final max = setWorkouts.volume.max();
    final id = setWorkouts.id;
    final query = selectOnly(setWorkouts)
      ..where(setWorkouts.id.isNotIn([setId]))
      ..where(setWorkouts.exerciseId.equals(exerciseId))
      ..addColumns([max, id]);

    return query.map((row) {
      final _id = row.read(id);
      final _max = row.read(max);
      if (_id == null || _max == null) return null;
      return [_id, _max];
    }).getSingle();
  }

  Future<List> findMaxWeigth(int exerciseId, int setId) async {
    final max = setWorkouts.maxWeigth.max();
    final id = setWorkouts.id;

    final query = selectOnly(setWorkouts)
      ..where(setWorkouts.id.isNotIn([setId]))
      ..where(setWorkouts.exerciseId.equals(exerciseId))
      ..addColumns([max, id]);

    return query.map((row) {
      final _id = row.read(id);
      final _max = row.read(max);
      if (_id == null || _max == null) return null;
      return [_id, _max];
    }).getSingle();
  }

  // UPDATES AND CRETIONS

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

  Future<int> saveSet(modelsApp.SetWorkout set, int workoutId) {
    return transaction(() async {
      final exeId = set.exercise.id;
      final repsSet = set.reps;

      final setId = await into(setWorkouts).insert(
          SetWorkout(
              maxWeigth: set.maxWeigth,
              volume: set.volume,
              id: set.id,
              workOutId: workoutId,
              exerciseId: exeId),
          mode: InsertMode.replace);

      await (delete(reps)..where((entry) => entry.setId.equals(setId))).go();

      if (repsSet.length == 0)
        await (delete(setWorkouts)..where((s) => s.id.equals(setId))).go();

      for (final rep in repsSet) {
        await into(reps).insert(
            RepsCompanion.insert(
                note: rep.notes == null ? "" : Value(rep.notes),
                reps: rep.reps,
                weight: rep.weight,
                rpe: rep.rpe,
                setId: setId),
            mode: InsertMode.replace);
      }

      return setId;
    });
  }

  Future<void> updateRoutineBds(
      {int exericiseId, int routineId, bool remove = false}) async {
    final rts =
        await (select(routine)..where((e) => e.id.equals(routineId))).get();
    final bds = await (select(exerciseBodyParts)
          ..where((e) => e.exerciseId.equals(exericiseId)))
        .get();

    if (rts.isEmpty || bds.isEmpty) return;

    final rt = rts[0];

    final Map<BodyPartEnum, int> newBds =
        rt.bodyParts?.bds != null ? rt.bodyParts.bds : {};

    bds.forEach((e) {
      final bd = e.bodyPart;
      if (newBds.containsKey(e.bodyPart)) {
        newBds[bd] = remove ? newBds[bd] - 1 : newBds[bd] + 1;
        return;
      }
      newBds[bd] = remove ? 0 : 1;
    });

    final newRoutine = RoutineData(
        id: rt.id,
        groupId: rt.groupId,
        name: rt.name,
        duration: rt.duration,
        difficulty: rt.difficulty,
        notes: rt.notes,
        bodyParts: RoutineBodyParts(newBds),
        timesCopied: rt.timesCopied);

    await into(routine).insert(newRoutine, mode: InsertMode.replace);
  }

  // COMPLEX DELETES

  Future<void> deleteGroupRoutine(int groupId) async {
    return transaction(() async {
      final routines = await (select(routine)
            ..where((t) => t.groupId.equals(groupId)))
          .get();
      for (final routine in routines)
        await (delete(routineSet)..where((t) => t.routineId.equals(routine.id)))
            .go();
      await (delete(routine)..where((t) => t.groupId.equals(groupId))).go();
      await (delete(routineGroup)..where((t) => t.id.equals(groupId))).go();
    });
  }

  Future<void> deleteRoutine(int routineId) {
    return transaction(() async {
      await (delete(routineSet)..where((t) => t.routineId.equals(routineId)))
          .go();
      await (delete(routine)..where((t) => t.id.equals(routineId))).go();
    });
  }

  Future<void> deleteRoutineSet(int setId) =>
      (delete(routineSet)..where((t) => t.id.equals(setId))).go();

  Future<void> deleteSet(int setId) {
    return transaction(() async {
      await (delete(reps)..where((e) => e.setId.equals(setId))).go();
      await (delete(setWorkouts)..where((e) => e.id.equals(setId))).go();
    });
  }

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

  // BASIC QUERIES

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

  Future insertExercise(Exercise exe) =>
      into(exercises).insert(exe, mode: InsertMode.replace);
  Future<void> saveGroupRoutine(RoutineGroupCompanion group) =>
      into(routineGroup).insert(group, mode: InsertMode.replace);

  Future<void> saveRoutine(RoutineCompanion rt) =>
      into(routine).insert(rt, mode: InsertMode.replace);

  Future<void> saveSetRoutine(RoutineSetCompanion set) =>
      into(routineSet).insert(set, mode: InsertMode.replace);

  Future<int> saveWorkOut(WorkoutsCompanion wk) =>
      into(workouts).insert(wk, mode: InsertMode.replace);
}

class ExerciseWithBodyParts {
  final Exercise exe;
  final List<BodyPartEnum> bodyParts;
  ExerciseWithBodyParts({this.exe, this.bodyParts});
}
