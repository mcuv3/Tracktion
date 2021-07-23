import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/util/enumToString.dart';

import '../../colors/custom_colors.dart';

class DifficultyWidget extends StatelessWidget {
  const DifficultyWidget({
    Key? key,
    required this.exs,
  }) : super(key: key);

  final Exercise exs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 0.2),
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0),
              BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0)
            ]),
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Difficulty : ',
                  style: TextStyle(
                      fontFamily: "CarterOne",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.exercise)),
              TextSpan(
                  text: ' ${enumToString(exs.difficulty)}',
                  style: TextStyle(
                      fontFamily: "CarterOne",
                      color: Theme.of(context).colorScheme.routines)),
            ],
          ),
        ),
      ),
    );
  }
}
