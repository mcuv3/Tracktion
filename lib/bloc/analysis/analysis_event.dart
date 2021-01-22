part of 'analysis_bloc.dart';

@immutable
abstract class AnalysisEvent {}

class StreamAnalysis extends AnalysisEvent {
  final List<int> exesIds;

  StreamAnalysis(this.exesIds);
}
