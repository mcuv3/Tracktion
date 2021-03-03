import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final SQLDatabase db;

  RoutineBloc(this.db) : super(RoutineLoading());

  @override
  Stream<RoutineState> mapEventToState(
    RoutineEvent event,
  ) async* {
    if (event is StreamRoutine) {
      yield* _streamRoutine(event);
    } else if (event is DeleteSet) {
      _deleteSet(event);
    } else if (event is DeleteRep) {
      _deleteRep(event);
    } else if (event is SaveRep) {
      _saveRep(event);
    } else if (event is SaveSet) {
      _saveSet(event);
    }
  }

  Stream<RoutineState> _streamRoutine(StreamRoutine event) async* {
    yield RoutineLoading();
    try {} catch (e) {
      print(e);
      yield RoutineFailure("Something went wrong fetching routine.");
    }
  }

  Stream<RoutineState> _deleteSet(RoutineEvent event) {}

  Stream<RoutineState> _deleteRep(DeleteRep event) {}

  Stream<RoutineState> _saveRep(SaveRep event) {}

  Stream<RoutineState> _saveSet(SaveSet event) {}
}
