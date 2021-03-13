import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/db/database.dart';

import '../../models/app/index.dart' as modelsApp;

part 'exercisestream_state.dart';

class ExerciseStreamCubit extends Cubit<ExerciseStreamState> {
  final SQLDatabase db;
  ExerciseStreamCubit({required this.db}) : super(ExerciseStreamInitial());

  void streamExercise(int exerciseId) {
    if (state is ExeStream) {}
    final exe = this.db.findExerciseStream(exerciseId);
    emit(ExeStream(exe));
  }
}
