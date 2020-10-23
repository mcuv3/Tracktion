import 'package:flutter/material.dart';
import 'package:tracktion/models/boyd-parts.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/exercise-search-shape.dart';
import 'package:tracktion/widgets/body-part.dart';
import '../colors/custom_colors.dart';

class SearchExercise extends StatelessWidget {
  static const routeName = '/search-exercise';

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final bodyPart = ModalRoute.of(context).settings.arguments as BodyPart;

    return Scaffold(
      body: Stack(
        children: [
          AbstractShape(
            width: double.infinity,
            height: query.size.height,
            shape: ExerciseSearchShape(Theme.of(context).colorScheme.routines),
          ),
          Center(
              child: Hero(
                  tag: bodyPart, child: BodyPartWidget(bodyPart, 200, 200)))
        ],
      ),
    );
  }
}
