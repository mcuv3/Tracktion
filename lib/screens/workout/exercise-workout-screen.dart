import 'package:flutter/material.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/exercise.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/reps-item.dart';
import '../../colors/custom_colors.dart';
import 'package:tracktion/shapes/add-exercise.dart';

class ExerciseWorkOut extends StatefulWidget {
  static const routeName = '/add-exercise-workout';

  @override
  _ExerciseWorkOutState createState() => _ExerciseWorkOutState();
}

class _ExerciseWorkOutState extends State<ExerciseWorkOut> {
  List<dynamic> bodyParts = [];
  Exercise exs;
  @override
  void initState() {
    super.initState();

    this.bodyParts = BodyPart.values.map((b) {
      if (b == BodyPart.Quadriceps || b == BodyPart.Legs)
        return {"body": b, "active": true};
    }).toList()
      ..removeWhere((element) => element == null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    exs = ModalRoute.of(context).settings.arguments;
  }

  void updateExes() {
    print("THIS WORKS");
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
                actions: [
                  IconButton(
                    icon: Icon(Icons.info),
                    iconSize: 26,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 26,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AddEditExerciseScreen.routeName,
                          arguments: {
                            "exe": exs,
                            "updateCallBack": updateExes
                          });
                    },
                  ),
                ],
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
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 0.2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    spreadRadius: 0),
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ]),
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            exs.name,
                            style: Theme.of(context).textTheme.title,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) => BodyPartWidget(
                              exs.bodyParts[i],
                              active: true,
                              bgColor: Colors.black,
                            ),
                            itemCount: exs.bodyParts.length,
                          ),
                        ),
                      ],
                    ),
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
