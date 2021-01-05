import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/DatePicker.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/reps-item.dart';
import 'package:tracktion/widgets/ui/IconDropDown.dart';
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
  var delitionMode = false;
  List<int> selectedSets = [];

  var init = false;

  @override
  void initState() {
    currentDate = DateTime.now();
    _pageController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 500.0).animate(_pageController);
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout());
    });
  }

  void viewCommentHandler(Rep rep) async {
    if (delitionMode) return selectItemHandler(rep.setId);

    var isNew = rep.notes == "";
    var updatedRep = await noteRepModal(context: context, rep: rep);

    if (updatedRep == null && !isNew) {
      updatedRep = Rep(
          id: rep.id,
          notes: "",
          reps: rep.reps,
          rpe: rep.rpe,
          weight: rep.weight,
          setId: rep.setId);
    }

    if (updatedRep != null && updatedRep.notes != rep.notes)
      BlocProvider.of<WorkoutBloc>(context).add(SaveRep(rep: updatedRep));
  }

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
      "setId": exerciseWorkout.id,
      "fromWorkout": true,
    });
  }

  List<Union3<Exercise, Rep, String>> mutateSets(List<SetWorkout> sets) {
    final List<Union3<Exercise, Rep, String>> items = [];
    sets.forEach((set) {
      set.exercise.setId = set.id;
      items.add(set.exercise.asFirst());
      set.reps.forEach((rep) {
        rep.setId = set.id;
        return items.add(rep.asSecond());
      });
      items.add("".asThird());
    });
    return items;
  }

  Widget buildHeader(
      {BuildContext context, String title, int index, int setId}) {
    var selectedToDelete = selectedSets.contains(setId);

    return Container(
      padding: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        border: delitionMode
            ? Border.all(
                color: selectedToDelete ? Colors.red : Colors.transparent,
                width: 1)
            : null,
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

  void selectItemHandler(int setId) {
    setState(() {
      if (selectedSets.contains(setId))
        selectedSets.remove(setId);
      else
        selectedSets.add(setId);
    });
  }

  void deleteSetsHandler() {
    if (selectedSets.length > 0) {
      BlocProvider.of<WorkoutBloc>(context).add(DeleteSets(selectedSets));
      setState(() {
        selectedSets = [];
      });
    }
  }

  BoxDecoration repStyle(int itemIndex, int setId) {
    var selectedToDelete = selectedSets.contains(setId);
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(delitionMode ? 0.5 : 0.2),
          spreadRadius: 4,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      border: delitionMode
          ? Border(
              left: BorderSide(
                  color: selectedToDelete ? Colors.red : Colors.transparent,
                  width: 1),
              right: BorderSide(
                  color: selectedToDelete ? Colors.red : Colors.transparent,
                  width: 1))
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: delitionMode
              ? [
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.trash,
                        size: 24,
                      ),
                      onPressed: deleteSetsHandler),
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.times,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          delitionMode = false;
                        });
                      }),
                ]
              : [
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.plusCircle,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(BodyPartsScreen.routeName);
                      }),
                  Container(
                      child: IconDropDown(
                    icons: [
                      Icon(Icons.timeline),
                      Icon(Icons.view_agenda),
                      Icon(Icons.settings),
                    ],
                    backgroundColor: Theme.of(context).colorScheme.analysis,
                    iconColor: Colors.white,
                    onChange: (index) {
                      print(index);
                    },
                  )),
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
                          return StreamBuilder(
                            builder: (context, sts) {
                              if (sts.connectionState ==
                                  ConnectionState.active) {
                                List<SetWorkout> sets = sts.data;
                                final items = mutateSets(sts.data);
                                return Container(
                                  width: size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) {
                                      Widget item;

                                      items[i].switchCase(
                                          (exe) => item = GestureDetector(
                                              onLongPress: () {
                                                if (delitionMode) return;
                                                setState(() {
                                                  delitionMode = true;
                                                });
                                              },
                                              onTap: () {
                                                if (!delitionMode) {
                                                  return showSetDetails(
                                                      setId: exe.setId,
                                                      sets: sets);
                                                }
                                                selectItemHandler(exe.setId);
                                              },
                                              child: buildHeader(
                                                  context: context,
                                                  title: exe.name,
                                                  index: i,
                                                  setId: exe.setId)),
                                          (rep) => item = GestureDetector(
                                                onLongPress: () {
                                                  if (delitionMode) return;
                                                  setState(() {
                                                    delitionMode = true;
                                                  });
                                                },
                                                onTap: () {
                                                  if (!delitionMode)
                                                    return showSetDetails(
                                                        setId: rep.setId,
                                                        sets: sets);
                                                  selectItemHandler(rep.setId);
                                                },
                                                child: Container(
                                                  decoration: delitionMode
                                                      ? repStyle(i, rep.setId)
                                                      : null,
                                                  child: RepItem(
                                                    hasComment: rep.notes != "",
                                                    reps: rep.reps,
                                                    weight: rep.weight,
                                                    rpe: rep.rpe,
                                                    onPressComment: () =>
                                                        viewCommentHandler(rep),
                                                  ),
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
