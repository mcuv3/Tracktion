import 'package:flutter/material.dart';
import 'package:tracktion/models/app/set.dart';
import 'package:tracktion/widgets/items/GraphExerciseItem.dart';

class WorkoutAnalysisScreen extends StatelessWidget {
  final List<SetWorkout> sets;

  WorkoutAnalysisScreen(this.sets);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) => GraphExerciseItem(sets[i]),
      itemCount: sets.length,
    );
  }
}
