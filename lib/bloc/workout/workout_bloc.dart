import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/bloc/common/Workout.dart';
import 'package:tracktion/util/analysis/getSetMaxWeigth.dart';
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
  final Common common;
  WorkoutBloc({@required this.db, @required this.common})
      : super(WorkoutInitial());

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
      await this.db.deleteSet(event.setId);
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
      var willDeleteSet = event.set.reps.length == 0;

      var exe = modelsApp.Exercise(
          id: currentExe.id,
          difficulty: currentExe.difficulty,
          name: currentExe.name,
          notes: currentExe.notes,
          lastWorkouts: currentExe.lastWorkouts,
          maxWeigth: currentExe.maxWeigth,
          maxVolume: currentExe.maxVolume,
          bodyParts: currentExe.bodyParts);

      var volume = getSetVolume(event.set.reps);
      var maxWeigth = getSetMaxWeigth(event.set.reps);

      if (event.isEdit) {
        if (willDeleteSet) {
          exe.lastWorkouts.removeWhere((wk) => wk.date == event.date);
          if (volume == exe.maxVolume)
            exe.maxVolume = await this.db.findMaxVolume(exe.id);

          if (maxWeigth == exe.maxWeigth)
            exe.maxWeigth = await this.db.findMaxWeigth(exe.id);
        }
        exe = consenceMaxes(
            exe: exe,
            maxWeigth: maxWeigth,
            volume: volume,
            willDelete: willDeleteSet);
      } else {
        if (exe.lastWorkouts.length >= 12) exe.lastWorkouts.removeAt(11);
        exe.lastWorkouts.insert(
            0,
            modelsApp.SetResume(
                date: event.date,
                maxWeigth: maxWeigth,
                volume: volume,
                reps: event.set.reps.length));

        exe = consenceMaxes(
            exe: exe,
            maxWeigth: maxWeigth,
            volume: volume,
            willDelete: willDeleteSet);
      }

      final lastWorkoutsString = exe.lastWorkoutsToString();

      await this.db.insertExercise(Exercise(
          id: exe.id,
          difficulty: exe.difficulty,
          lastWorkouts: lastWorkoutsString,
          maxVolume: exe.maxVolume,
          maxWeigth: exe.maxWeigth,
          name: exe.name,
          notes: exe.notes));

      await this.db.saveSet(
          modelsApp.SetWorkout(
              id: event.set.id,
              exercise: exe,
              volume: volume,
              maxWeigth: maxWeigth,
              reps: event.set.reps),
          workout.id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _copySets(CopySets event) async {
    try {
      final filters = event.workoutFilters;
      final workout = await this.db.findOrCreateWorkout(event.date);
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
                  maxWeigth: set.maxWeigth,
                  volume: set.volume,
                  reps: filteredReps,
                  exercise: set.exercise,
                  id: null);
            }
            return null;
          })
          .where((s) => s != null)
          .toList();

      for (final set in cleanedSets) await this.db.saveSet(set, workout.id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveRep(SaveRep event) async {
    try {
      print(event.rep.setId);

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

  void _deleteSets(DeleteSets event) async {
    try {
      final sets = event.setsId;

      for (final id in sets) {
        await this.db.deleteSet(id);
      }
    } catch (e) {
      print(e);
    }
  }
}
