import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routinestream_event.dart';
part 'routinestream_state.dart';

class RoutinestreamBloc extends Bloc<RoutinestreamEvent, RoutinestreamState> {
  RoutinestreamBloc() : super(RoutinestreamInitial());

  @override
  Stream<RoutinestreamState> mapEventToState(
    RoutinestreamEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
