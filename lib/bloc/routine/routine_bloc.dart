import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final SQLDatabase db;

  RoutineBloc(this.db) : super(RoutinesInitial());

  @override
  Stream<RoutineState> mapEventToState(
    RoutineEvent event,
  ) async* {
    if (event is StreamRoutines) {
      yield* _streamRoutines(event);
    } else if (event is StreamGroupRoutines){
      yield* _streamGroupRoutine();
    } else if (event is CreateGroupRoutine){
      yield* _createGroupRoutine(event);
    } else if (event is CreateRoutine) {
      yield* _createRoutine(event);
    } else if (event is EditRoutine) {
      yield* _editRoutine(event);
    } else if (event is DeleteRoutine) {
      yield* _deleteRoutine(event);
     } else if (event is DeleteGroupRoutine){
      yield* _deleteGroupRoutine(event);
    } 
  }

  Stream<RoutineState> _deleteRoutine(DeleteRoutine event) async* {
    final routines = (state as Routines).routines;
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineFailure("Cannot delete de Routine.");
      yield Routines(routines);
    }
  }
  Stream<RoutineState> _deleteGroupRoutine(DeleteGroupRoutine event) async* {
    final routines = (state as Routines).routines;
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineFailure("Cannot delete de Routine.");
      yield Routines(routines);
    }
  }

  Stream<RoutineState> _editRoutine(EditRoutine event) async* {
    final streamRoutines = (state as Routines).routines;
    yield RoutinesLoading();
    try {
      yield RoutineCreatedSuccess();
      yield Routines(streamRoutines);
    } catch (e) {
      print(e);
      yield RoutineFailure("Cannot edit the Routine");
      yield Routines(streamRoutines);
    }
  }

  Stream<RoutineState> _createRoutine(CreateRoutine event) async* {
    yield RoutinesLoading();
    try {
      final routine = event.routine;

      yield RoutineCreatedSuccess();
    } catch (e) {
      print(e);
      yield RoutineFailure("Cannot create the Routine");
    }
  }
  Stream<RoutineState> _createGroupRoutine(CreateGroupRoutine event) async* {
    yield RoutinesLoading();
    try {

      yield RoutineCreatedSuccess();
    } catch (e) {
      print(e);
      yield RoutineFailure("Cannot create the Routine");
    }
  }

  Stream<RoutineState> _streamRoutines(StreamRoutines event) async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineFailure("Something went wrong fetching routines.");
    }
  }

  Stream<RoutineState> _streamGroupRoutine() async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutineFailure("Something went wrong fetching routines.");
    }
  }
}
