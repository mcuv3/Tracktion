import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineGroupBloc extends Bloc<RoutineGroupEvent, RoutineGroupState> {
  final SQLDatabase db;

  RoutineGroupBloc(this.db) : super(RoutinesLoading());

  @override
  Stream<RoutineGroupState> mapEventToState(
    RoutineGroupEvent event,
  ) async* {
    if (event is StreamGroupRoutines) {
      yield* _streamGroupRoutines();
    } else if (event is SaveGroupRoutine) {
      yield* _saveGroupRoutine(event);
    } else if (event is DeleteGroupRoutine) {
      yield* _deleteGroupRoutine(event);
    }
  }

  Stream<RoutineGroupState> _deleteGroupRoutine(
      DeleteGroupRoutine event) async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineGroupFailure("Cannot delete de Group routine.");
    }
  }

  Stream<RoutineGroupState> _saveGroupRoutine(SaveGroupRoutine event) async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineGroupFailure("Cannot create the Routine");
    }
  }

  Stream<RoutineGroupState> _streamGroupRoutines() async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineGroupFailure("Something went wrong fetching routines.");
    }
  }
}