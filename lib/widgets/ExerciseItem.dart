import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';

class ExerciseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          tileColor: Colors.white,
          title: Text(
            'Difficulty: Hard',
            textAlign: TextAlign.end,
            style:
                TextStyle(color: Theme.of(context).colorScheme.exerciseLight),
          ),
          leading: Text(
            'DeadLift',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.start,
          ),
          dense: true,
          subtitle: Text(
            'Butt - Quadriceps - Back ',
            textAlign: TextAlign.end,
            style:
                TextStyle(color: Theme.of(context).colorScheme.routinesLight),
          ),
        ),
      ),
    );
  }
}
