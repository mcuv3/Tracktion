import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial());

  @override
  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
