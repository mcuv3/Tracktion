import 'package:flutter/material.dart';
import 'package:tracktion/widgets/items/GraphExerciseItem.dart';

class WorkoutAnalysisScreen extends StatefulWidget {
  @override
  _WorkoutAnalysisScreenState createState() => _WorkoutAnalysisScreenState();
}

class _WorkoutAnalysisScreenState extends State<WorkoutAnalysisScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GraphExerciseItem(),
        GraphExerciseItem(),
        GraphExerciseItem(),
      ],
    );
  }
}
