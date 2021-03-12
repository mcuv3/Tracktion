import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final SQLDatabase db;
  AnalysisBloc({required this.db}) : super(AnalysisInitial());

  @override
  Stream<AnalysisState> mapEventToState(
    AnalysisEvent event,
  ) async* {
    if (event is StreamAnalysis) {
      yield* _streamAnalysis(event);
    }
  }

  Stream<AnalysisState> _streamAnalysis(StreamAnalysis event) async* {
    yield AnalysisLoading();
    try {} catch (e) {
      print(e);
    }
  }
}
