import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial());

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    if (event is FetchWorkout) {
      yield* _fetchWorkout(event);
    }
  }

  Stream<WorkoutState> _fetchWorkout(FetchWorkout event) async* {
    yield WorkoutLoading();
    try {
      final date = event.date;
      await Future.delayed(Duration(seconds: 3));
      yield WorkoutInitial();
    } catch (e) {
      yield WorkoutFailed("Cannot fetch this workout");
    }
  }
}
