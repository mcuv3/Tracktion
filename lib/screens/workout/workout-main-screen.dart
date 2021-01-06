import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/inputs/DatePicker.dart';
import 'package:tracktion/widgets/items/WorkoutItem.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/ui/IconDropDown.dart';

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
  List<int> orderSets = [];
  var sortMode = false;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: delitionMode | sortMode
              ? [
                  if (!sortMode)
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
                          sortMode = false;
                        });
                      }),
                ]
              : [
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.sort,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          sortMode = !sortMode;
                        });
                      }),
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
        body: Column(
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
              flex: 1,
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) => Transform.translate(
                  offset: Offset(animation.value * (direction ? -1 : 1), 0.0),
                  child: BlocBuilder<WorkoutBloc, WorkoutState>(
                    builder: (context, state) {
                      if (state is WorkoutSets) {
                        return StreamBuilder(
                          builder: (context, sts) {
                            if (sts.connectionState == ConnectionState.active) {
                              List<SetWorkout> sets = sts.data;
                              if (sets.length == 0) {
                                setState(() {
                                  for (final set in sets) orderSets.add(set.id);
                                });
                              }
                              if (sortMode)
                                sets.sort((a, b) => orderSets.indexOf(a.id));
                              var content = [
                                for (final set in sets)
                                  InkWell(
                                    key: ValueKey(set.id),
                                    onLongPress: sortMode
                                        ? null
                                        : () {
                                            if (delitionMode) return;
                                            setState(() {
                                              delitionMode = true;
                                            });
                                          },
                                    highlightColor: Colors.red,
                                    splashColor: Colors.red.withOpacity(0.3),
                                    onTap: () {
                                      if (!delitionMode) {
                                        return showSetDetails(
                                            setId: set.id, sets: sets);
                                      }
                                      selectItemHandler(set.id);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: WorkoutItem(
                                        isSortMode: sortMode,
                                        delitionMode: delitionMode,
                                        isSelected:
                                            selectedSets.contains(set.id),
                                        onViewComment: (v) {},
                                        set: set,
                                      ),
                                    ),
                                  )
                              ];

                              return Container(
                                width: size.width,
                                child: !sortMode
                                    ? Column(
                                        children: content,
                                      )
                                    : ReorderableListView(
                                        onReorder: (prev, next) {
                                          var ids = orderSets;
                                          if (ids.length == 0)
                                            for (final set in sets)
                                              ids.add(set.id);

                                          print(ids);
                                          if (next >= orderSets.length)
                                            next = orderSets.length - 1;
                                          // if (next > prev) next -= 1;
                                          final item = ids.removeAt(prev);
                                          ids.insert(next, item);
                                          print(ids);

                                          setState(() {
                                            orderSets = ids;
                                          });
                                        },
                                        children: content
                                        // itemCount: sets.length,
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
    );
  }
}
