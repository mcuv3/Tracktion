import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/util/analysis/getSetMaxWeight.dart';
import 'package:tracktion/util/analysis/getSetVolume.dart';
import 'package:tracktion/util/analysis/mergeSetLastWorkout.dart';
import 'package:tracktion/util/toDayDate.dart';

import '../../models/app/index.dart' as modelsApp;
import '../../models/db/database.dart';
import '../../util/mapWithIndex.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final SQLDatabase db;

  WorkoutBloc(this.db) : super(WorkoutInitial());

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    if (event is FetchWorkout) {
      yield* _fetchWorkout(event);
    } else if (event is DeleteWorkout) {
      yield* _deleteWorkout(event);
    } else if (event is DeleteSet) {
      _deleteSet(event);
    } else if (event is DeleteRep) {
      _deleteRep(event);
    } else if (event is SaveRep) {
      _saveRep(event);
    } else if (event is SaveSet) {
      _saveSet(event);
    } else if (event is DeleteSets) {
      _deleteSets(event);
    } else if (event is CopySets) {
      _copySets(event);
    } else if (event is CopyRoutine) {
      _copyRoutine(event);
    } else if (event is UpdateWorkoutMetadata) {
      _updateWorkoutMetadata(event);
    }
  }

  Future<void> _updateWorkoutMetadata(UpdateWorkoutMetadata event) async {
    try {
      final workout = await db.findWorkoutByDate(event.workoutDate);
      if (event.type == RequestType.Delete) {
        workout.metadata.exesToBodyParts
            .removeWhere((key, value) => event.exesIds.contains(key));
      } else if (event.exesIds.isNotEmpty) {
        workout.metadata.exesToBodyParts
            .addEntries([MapEntry(event.exesIds[0], event.bodyParts.toSet())]);
      }
      workout.metadata.syncBodyParts();
      await db.saveWorkOut(Workout(
          id: workout.id,
          metadata: workout.metadata.toJson(),
          date: workout.date));
      print(Workout(
          id: workout.id,
          metadata: workout.metadata.toJson(),
          date: workout.date));
    } catch (e) {
      print(e);
    }
  }

  Stream<WorkoutState> _fetchWorkout(FetchWorkout event) async* {
    DateTime date = toDayDate(DateTime.now());
    if (event.date == null && state is WorkoutSets) {
      date = (state as WorkoutSets).date;
    } else if (event.date != null) date = toDayDate(event.date);
    yield WorkoutLoading();
    try {
      final sets = this.db.findSetsByDate(date);

      yield WorkoutSets(sets: sets, date: date);
    } catch (e) {
      yield WorkoutTransactionFailed("Cannot fetch this workout");
    }
  }

  Stream<WorkoutState> _deleteWorkout(DeleteWorkout event) async* {
    yield WorkoutLoading();
    try {
      await this.db.deleteWorkout(event.workoutId);
    } catch (e) {}
  }

  Future<void> _deleteSet(DeleteSet event) async {
    try {
      var exe = event.set.exercise;
      var setId = event.set.id;

      exe.removeSet(setId);
      await exe.verifyMaxWeight(setId: setId, newSetWeight: null);
      await exe.verifyMaxVolume(setId: setId, newSetVolume: null);
      exe.syncMaxes(willDelete: true, setId: setId);
      await _saveExercise(exe);
      await this.db.deleteSet(setId);
      return event.set;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteRep(DeleteRep event) async {
    try {
      await this.db.deleteRep(event.rep);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveSet(SaveSet event) async {
    try {
      final workout = await this.db.findOrCreateWorkout(event.date);
      var currentExe = event.set.exercise;
      var isCreation = !event.isEdit;

      var exe = currentExe.copy();
      var volume = getSetVolume(event.set.reps);
      var maxWeight = getSetMaxWeight(event.set.reps);

      var newOrUpdatedSet = modelsApp.SetResume(
          setId: event.set.id,
          date: event.date,
          maxWeight: maxWeight,
          volume: volume,
          reps: event.set.reps.length);

      if (event.isEdit) {
        var indexLastWorkout =
            exe.lastWorkouts.indexWhere((set) => set.setId == event.set.id);
        if (indexLastWorkout != -1)
          exe.lastWorkouts[indexLastWorkout] = newOrUpdatedSet;
        await exe.verifyMaxVolume(
            newSetVolume: newOrUpdatedSet.volume, setId: newOrUpdatedSet.setId);
        await exe.verifyMaxWeight(
            newSetWeight: newOrUpdatedSet.maxWeight,
            setId: newOrUpdatedSet.setId);
      } else {
        if (exe.lastWorkouts.length >= 12) exe.lastWorkouts.removeAt(11);
        exe.lastWorkouts.insert(0, newOrUpdatedSet);
      }

      exe = syncMaxes(
          setId: newOrUpdatedSet.setId,
          exe: exe,
          maxWeight: maxWeight,
          volume: volume);

      final setId = await this.db.saveSet(
          modelsApp.SetWorkout(
              id: event.set.id,
              exercise: exe,
              volume: volume,
              maxWeight: maxWeight,
              reps: event.set.reps),
          workout.id);

      if (isCreation) {
        this._updateWorkoutMetadata(UpdateWorkoutMetadata(
            exesIds: [exe.id],
            bodyParts: exe.bodyParts,
            type: RequestType.Create,
            workoutDate: event.date));
        exe.lastWorkouts[0].setId = setId;
        if (exe.lastWorkouts.length == 1) {
          exe.maxVolumeSetId = setId;
          exe.maxWeightSetId = setId;
        }
      }

      await _saveExercise(exe);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _copySets(CopySets event) async {
    try {
      final filters = event.workoutFilters;
      final cleanedSets = event.sets
          .map((set) {
            if (filters[set.id]["active"]) {
              final filteredReps = set.reps.whereIndex((e, i) {
                if (filters[set.id]["reps"][i]) {
                  e.id = null;
                  return true;
                } else
                  return false;
              }).toList();

              return modelsApp.SetWorkout(
                  maxWeight: set.maxWeight,
                  volume: set.volume,
                  reps: filteredReps,
                  exercise: set.exercise,
                  id: null);
            }
            return null;
          })
          .where((s) => s != null)
          .toList();

      await Future.wait(cleanedSets.map((s) =>
          this._saveSet(SaveSet(date: event.date, isEdit: false, set: s))));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _copyRoutine(CopyRoutine event) async {
    try {
      final List<modelsApp.SetWorkout> sets = [];
      for (final set in event.sets) {
        final exe = await this.db.findExercise(set.exerciseId);
        final reps = await this._getRoutineReps(set, exe);

        sets.add(modelsApp.SetWorkout(
            maxWeight: 0,
            volume: 0,
            reps: reps,
            exercise: modelsApp.Exercise(
                difficulty: exe.difficulty,
                id: exe.id,
                bodyParts: [],
                lastWorkouts:
                    modelsApp.Exercise.stringToLastWorkouts(exe.lastWorkouts),
                maxVolume: exe.maxVolume,
                maxVolumeSetId: exe.maxVolumeSetId,
                maxWeight: exe.maxWeight,
                maxWeightSetId: exe.maxWeightSetId,
                name: exe.name,
                notes: exe.notes),
            id: null));
      }

      await Future.wait(sets.map((s) =>
          this._saveSet(SaveSet(date: event.date, isEdit: false, set: s))));
    } catch (e) {
      print("Copy Routine");
      print(e);
    }
  }

  Future<List<modelsApp.Rep>> _getRoutineReps(
      RoutineSetData set, Exercise exe) async {
    List<modelsApp.Rep> reps = [];

    final prevs = modelsApp.Exercise.stringToLastWorkouts(exe.lastWorkouts);

    switch (set.copyMethod) {
      case CopyMethod.Static:
        reps = List.filled(set.series, 0)
            .map((_) =>
                modelsApp.Rep(id: null, reps: 0, rpe: set.targetRpe, weight: 0))
            .toList();
        break;
      case CopyMethod.Previous:
        if (prevs.length != 0) {
          final setId = prevs[prevs.length - 1].setId;
          final _reps = await this.db.findReps(setId);
          reps = _reps
              .map((r) => modelsApp.Rep(
                  id: null,
                  reps: r.reps,
                  rpe: r.rpe,
                  weight: r.weight,
                  notes: r.note,
                  setId: null))
              .toList();
        }

        break;
      case CopyMethod.Smart:
        if (prevs.length != 0) {
          final setId = prevs[prevs.length - 1].setId;
          final _reps = await this.db.findReps(setId);
          double weigth = 0;
          int rps = 0;

          _reps.forEach((r) {
            rps += r.reps;
            weigth += r.weight;
          });

          reps = List.filled(
                  _reps.length,
                  modelsApp.Rep(
                      id: null,
                      reps: rps ~/ _reps.length,
                      rpe: set.targetRpe,
                      weight: weigth / _reps.length,
                      notes: "",
                      setId: null))
              .toList();
        }

        break;
      case CopyMethod.Percentage:
        final mr = set.repmax;
        reps = List.filled(set.series, 0)
            .map((_) => modelsApp.Rep(
                id: null,
                reps: set.series,
                rpe: set.targetRpe,
                weight: (mr * set.percentage) / 100))
            .toList();
        break;
    }

    return reps;
  }

  Future<void> _saveRep(SaveRep event) async {
    try {
      final rep = Rep(
          id: event.rep.id,
          note: event.rep.notes,
          weight: event.rep.weight,
          reps: event.rep.reps,
          rpe: event.rep.rpe,
          setId: event.rep.setId);
      await this.db.saveRep(rep);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteSets(DeleteSets event) async {
    try {
      Map<int, modelsApp.Exercise> exes = {};
      for (final setWk in event.sets) {
        if (exes[setWk.exercise.id] == null)
          exes[setWk.exercise.id] = setWk.exercise;
        else
          setWk.exercise = exes[setWk.exercise.id];
        await this._deleteSet(DeleteSet(setWk));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> _saveExercise(modelsApp.Exercise exe) =>
      this.db.insertExercise(Exercise(
          id: exe.id,
          maxVolumeSetId: exe.maxVolumeSetId,
          maxWeightSetId: exe.maxWeightSetId,
          difficulty: exe.difficulty,
          lastWorkouts: exe.lastWorkoutsToString(),
          maxVolume: exe.maxVolume,
          maxWeight: exe.maxWeight,
          name: exe.name,
          notes: exe.notes));
}
