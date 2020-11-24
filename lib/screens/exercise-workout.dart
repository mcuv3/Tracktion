import 'package:flutter/material.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/reps-item.dart';
import '../colors/custom_colors.dart';
import 'package:tracktion/shapes/add-exercise.dart';

class ExerciseWorkOut extends StatefulWidget {
  static const routeName = '/add-exercise-workout';

  @override
  _ExerciseWorkOutState createState() => _ExerciseWorkOutState();
}

class _ExerciseWorkOutState extends State<ExerciseWorkOut> {
  List<dynamic> bodyParts = [];

  @override
  void initState() {
    super.initState();

    this.bodyParts = BodyPart.values.map((b) {
      if (b == BodyPart.Quadriceps || b == BodyPart.Legs)
        return {"body": b, "active": true};
    }).toList()
      ..removeWhere((element) => element == null);
    ;
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print(bodyParts);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          AbstractShape(
            width: double.infinity,
            height: query.size.height,
            shape: ShapeAddExerciseUp(Theme.of(context).colorScheme.analysis),
          ),
          AbstractShape(
            width: double.infinity,
            height: query.size.height,
            shape: ShapeAddExerciseDown(Theme.of(context).colorScheme.analysis),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text(
                          'DeadLift',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              setState(() {
                                bodyParts[i]['active'] =
                                    !bodyParts[i]['active'];
                              });
                            },
                            child: BodyPartWidget(
                              bodyParts[i]['body'],
                              active: true,
                              bgColor: Colors.black,
                            ),
                          ),
                          itemCount: bodyParts.length,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (ctx, i) => RepItem(),
                  ),
                ),
              )
            ],
          )
        ]),
        floatingActionButton: Card(
          color: Theme.of(context).colorScheme.exercise,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}

// TODO: scketch the screen for adding sets,reps,rpe to a workout
