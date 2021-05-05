import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/app/index.dart' as modelsApp;
import 'package:tracktion/models/db/database.dart';

part 'routines_event.dart';
part 'routines_state.dart';

class RoutinesBloc extends Bloc<RoutinesEvent, RoutinesState> {
  final SQLDatabase db;

  RoutinesBloc(this.db) : super(RoutinesLoading());
  @override
  Stream<RoutinesState> mapEventToState(
    RoutinesEvent event,
  ) async* {
    if (event is StreamRoutines) {
      yield* _streamRoutines(event);
    } else if (event is SaveFullRoutine) {
      yield* _savefullRoutine(event);
    } else if (event is DeleteRoutine) {
      yield* _deleteRoutine(event);
    } else if (event is SaveRoutine) {
      yield* _saveRoutine(event);
    } else if (event is FetchRoutines) {
      yield* _streamAllRoutines(event);
    }
  }

  Stream<RoutinesState> _streamRoutines(StreamRoutines event) async* {
    yield RoutinesLoading();
    try {
      final groupId = event.groupId;
      final routines = this.db.findRoutinesByGroup(groupId);

      yield Routines(routines);
    } catch (e) {
      print(e);
      yield RoutinesFailure("Something went wrong fetching routines.");
    }
  }

  Stream<RoutinesState> _streamAllRoutines(FetchRoutines event) async* {
    yield RoutinesLoading();
    try {
      final routines = await this.db.findRoutines();
      yield AllRoutines(routines);
    } catch (e) {
      print(e);
      yield RoutinesFailure("Something went wrong fetching routines.");
    }
  }

  Stream<RoutinesState> _deleteRoutine(DeleteRoutine event) async* {
    final stream = (state as Routines).routines;
    yield RoutinesLoading();
    try {
      await this.db.deleteRoutine(event.id);
      yield RoutinesSuccess();
      yield Routines(stream);
    } catch (e) {
      print(e);
      yield RoutinesFailure("Cannot delete de Group routine.");
    }
  }

  Stream<RoutinesState> _savefullRoutine(SaveFullRoutine event) async* {
    final stream = (state as Routines).routines;
    try {
      final sets = event.sets;
      for (final set in sets)
        await this.db.saveSetRoutine(set.toCompanion(true));
      await this.db.saveRoutine(event.routine.toCompanion(true));
      yield RoutinesSuccess();
      yield Routines(stream);
    } catch (e) {
      print(e);
      yield RoutinesFailure("Cannot create the Routine");
    }
  }

  Stream<RoutinesState> _saveRoutine(SaveRoutine event) async* {
    final stream = (state as Routines).routines;
    try {
      await this.db.saveRoutine(event.routine.toCompanion(true));
      yield RoutinesSuccess();
      yield Routines(stream);
    } catch (e) {
      print(e);
      yield RoutinesFailure("Cannot create the Routine");
    }
  }
}
