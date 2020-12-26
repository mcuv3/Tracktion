import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';

class ExerciseWorkoutTitle extends StatelessWidget {
  const ExerciseWorkoutTitle({
    Key key,
    @required this.exs,
  }) : super(key: key);

  final Exercise exs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 0.2),
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0),
              BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0)
            ]),
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Text(
          exs.name,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
