import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/DatePicker.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/reps-item.dart';
import 'package:union/union.dart';

import '../../colors/custom_colors.dart';
import '../index.dart';

class WorkOutScreen extends StatefulWidget {
  static const routeName = "/workout";

  @override
  _WorkOutScreenState createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen>
    with TickerProviderStateMixin {
  AnimationController _pageController;
  Animation<double> animation;
  bool direction = true;
  DateTime currentDate;
  var init = false;

  @override
  void initState() {
    currentDate = DateTime.now();
    _pageController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 500.0).animate(_pageController);
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout());
    });
  }

  void viewCommentHandler() {}

  void changeDateHandler(bool isRight) {
    isRight ? _pageController.forward() : _pageController.reverse();
    setState(() {
      direction = isRight;
      currentDate = DateTime(currentDate.year, currentDate.month,
          currentDate.day + (isRight ? 1 : -1));
    });
    BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout(date: currentDate));
  }

  void showSetDetails({@required int setId, @required List<SetWorkout> sets}) {
    final exerciseWorkout =
        sets.firstWhere((e) => e.id == setId, orElse: () => null);
    if (exerciseWorkout == null) return;
    Navigator.of(context).pushNamed(ExerciseWorkOut.routeName, arguments: {
      "exercise": exerciseWorkout.exercise,
      "reps": exerciseWorkout.reps,
      "setId": exerciseWorkout.id
    });
  }

  Widget buildHeader(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Theme.of(context).colorScheme.exercise,
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.plusCircle,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(BodyPartsScreen.routeName);
                }),
            IconButton(
                visualDensity: VisualDensity.compact,
                icon: FaIcon(FontAwesomeIcons.ellipsisV),
                onPressed: () {}),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(
            children: [
              BlocListener<WorkoutBloc, WorkoutState>(
                listener: (context, state) {
                  if (state is WorkoutSets) {
                    setState(() {
                      currentDate = state.date;
                    });
                  }
                },
                child: DatePicker(
                  changeDate: changeDateHandler,
                  currentDate: currentDate,
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, _) => Transform.translate(
                    offset: Offset(animation.value * (direction ? -1 : 1), 0.0),
                    child: BlocBuilder<WorkoutBloc, WorkoutState>(
                      builder: (context, state) {
                        if (state is WorkoutLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        if (state is WorkoutSets) {
                          // return PageView.builder(
                          //     controller: _pageController,
                          //     itemCount: 3,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, workout) =>
                          return StreamBuilder(
                            builder: (context, sts) {
                              if (sts.connectionState ==
                                  ConnectionState.active) {
                                List<SetWorkout> sets = sts.data;
                                final List<Union3<Exercise, Rep, String>>
                                    items = [];
                                sets.forEach((set) {
                                  set.exercise.setId = set.id;
                                  items.add(set.exercise.asFirst());
                                  set.reps.forEach((rep) {
                                    rep.setId = set.id;
                                    return items.add(rep.asSecond());
                                  });
                                  items.add("".asThird());
                                });

                                return Container(
                                  width: size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) {
                                      Widget item;

                                      items[i].switchCase(
                                          (exe) => item = GestureDetector(
                                              onTap: () => showSetDetails(
                                                  setId: exe.setId, sets: sets),
                                              child: buildHeader(
                                                  context, exe.name)),
                                          (rep) => item = GestureDetector(
                                                onTap: () => showSetDetails(
                                                    setId: rep.setId,
                                                    sets: sets),
                                                child: RepItem(
                                                  hasComment: rep.notes != "",
                                                  reps: rep.reps,
                                                  weight: rep.weight,
                                                  rpe: rep.rpe,
                                                  onPressComment:
                                                      viewCommentHandler,
                                                ),
                                              ),
                                          (_) => item = SizedBox(
                                                height: 10,
                                              ));
                                      return item;
                                    },
                                    itemCount: items.length,
                                  ),
                                );
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            stream: state.sets,
                          );
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
