import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/exercise.dart';
import 'package:tracktion/models/app/rep.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/modals/RepInputs.dart';
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
  List<Rep> sets = [];

  @override
  void initState() {
    super.initState();

    this.bodyParts = BodyPartEnum.values.map((b) {
      if (b == BodyPartEnum.Quadriceps || b == BodyPartEnum.Legs)
        return {"body": b, "active": true};
    }).toList()
      ..removeWhere((element) => element == null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    exs = ModalRoute.of(context).settings.arguments;
  }

  void editExerciseSuccessfulCallBack(Exercise exe) {
    setState(() {
      exs = exe;
      bodyParts = exe.bodyParts.map((e) {
        return {"active": true, "body": e};
      }).toList();
    });
  }

  void addRepeHandler() {
    var reps = 0;
    var rpe = 0;
    var weight = 0.0;

    if (sets.length > 0) {
      reps = sets[sets.length - 1].reps;
      weight = sets[sets.length - 1].weight;
      rpe = sets[sets.length - 1].rpe;
    }
    final rep = Rep(id: sets.length, reps: reps, rpe: rpe, weight: weight);
    setState(() {
      sets.add(rep);
    });
  }

  void changeCommentHandler(Rep rep) {
    // rep.updateNote = 'something';
    noteRepModal(context: context, rep: rep).then((updatedRep) {
      if (updatedRep != null) print(updatedRep.notes);
    });
  }

  void editRepHandler(Rep rep, int indexRep) {
    repInputsModal(context, rep).then((repUpadated) {
      setState(() {
        sets[indexRep] = repUpadated;
      });
    });
  }

  void removeRepHandler(int index) {
    setState(() {
      sets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
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
              shape:
                  ShapeAddExerciseDown(Theme.of(context).colorScheme.analysis),
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
                            AddEditBodyPartsScreen.routeName,
                            arguments: {
                              "exe": exs,
                              "updateCallBack": editExerciseSuccessfulCallBack
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
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ExerciseTitle(exs: exs),
                          DifficultyWidget(exs: exs),
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
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ListView.builder(
                      itemCount: sets.length,
                      itemBuilder: (ctx, i) => Dismissible(
                        key: Key(sets[i].id.toString()),
                        onDismissed: (direction) {
                          removeRepHandler(i);
                        },
                        child: GestureDetector(
                          onTap: () => editRepHandler(sets[i], i),
                          child: RepItem(
                            reps: sets[i].reps,
                            weight: sets[i].weight,
                            rpe: sets[i].rpe,
                            isExpanded: true,
                            onPressComment: () => changeCommentHandler(sets[i]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ]),
          floatingActionButton: FloatingActionButton(
            elevation: 6,
            backgroundColor: Theme.of(context).colorScheme.routines,
            onPressed: addRepeHandler,
            child: Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
          )),
    );
  }
}

class ExerciseTitle extends StatelessWidget {
  const ExerciseTitle({
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

class DifficultyWidget extends StatelessWidget {
  const DifficultyWidget({
    Key key,
    @required this.exs,
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

// TODO: scketch the screen for adding sets,reps,rpe to a workout
