import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';

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
      yield* _streamRoutines();
    } else if (event is SaveRoutines) {
      yield* _saveRoutine(event);
    } else if (event is DeleteRoutine) {
      yield* _deleteRoutine(event);
    }
  }

  Stream<RoutinesState> _deleteRoutine(DeleteRoutine event) async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutinesFailure("Cannot delete de Group routine.");
    }
  }

  Stream<RoutinesState> _saveRoutine(SaveRoutines event) async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutinesFailure("Cannot create the Routine");
    }
  }

  Stream<RoutinesState> _streamRoutines() async* {
    yield RoutinesLoading();
    try {} catch (e) {
      print(e);
      yield RoutinesFailure("Something went wrong fetching routines.");
    }
  }
}
