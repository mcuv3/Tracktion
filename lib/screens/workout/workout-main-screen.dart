import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/db/database.dart' as dbModels;
import 'package:tracktion/screens/analysis/workout-analysis-screen.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/forms/RoutineSetConfiguration.dart';
import 'package:tracktion/widgets/inputs/DatePicker.dart';
import 'package:tracktion/widgets/items/WorkoutItem.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/IconDropDown.dart';
import 'package:tracktion/widgets/ui/WorkoutEmpty.dart';

import '../../colors/custom_colors.dart';
import '../index.dart';

class WorkOutScreenService extends InheritedWidget {
  final BuildContext context;
  WorkOutScreenService({Key key, @required this.child, @required this.context})
      : super(key: key, child: child);

  final Widget child;

  static WorkOutScreenService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WorkOutScreenService>();
  }

  void routineSelectedHanlder(RoutineSlim routine, DateTime date) async {
    List<dbModels.RoutineSetData> sets = await showAnimatedModal(
        context,
        RoutinesSetConfuguration(
          routine: routine,
        ));

    if (sets == null) return;
    BlocProvider.of<WorkoutBloc>(context).add(CopyRoutine(sets, date));
  }

  @override
  bool updateShouldNotify(WorkOutScreenService oldWidget) {
    return true;
  }
}

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
  List<SetWorkout> selectedSets = [];
  List<int> orderSets = [];
  var sortMode = false;
  var analysisMode = false;
  var init = false;

  @override
  void initState() {
    currentDate = DateTime.now();
    _pageController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this)
          ..addListener(() => setState(() {}));
    // animation = Tween(begin: 0.0, end: 500.0).animate(_pageController);
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout());
    });
    super.initState();
  }

  void viewCommentHandler(Rep rep, SetWorkout set) async {
    if (delitionMode) return selectItemHandler(set);

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

  void changeDateHandler(DateTime newDate) {
    // isRight ? _pageController.forward() : _pageController.reverse();
    setState(() {
      // direction = isRight;
      currentDate = newDate;
    });
    BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout(date: newDate));
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

  void selectItemHandler(SetWorkout set) {
    setState(() {
      final indexSet = selectedSets.indexWhere((st) => st.id == set.id);
      if (indexSet != -1)
        selectedSets.removeAt(indexSet);
      else
        selectedSets.add(set);
    });
  }

  void deleteSetsHandler() {
    if (selectedSets.length > 0) {
      BlocProvider.of<WorkoutBloc>(context).add(DeleteSets(selectedSets));
      BlocProvider.of<WorkoutBloc>(context).add(UpdateWorkoutMetadata(
          type: RequestType.Delete,
          workoutDate: currentDate,
          exesIds: selectedSets.map((e) => e.exercise.id).toList()));

      setState(() {
        selectedSets = [];
        delitionMode = false;
      });
    }
  }

  void orderSetsHandler(int prev, int next, List<SetWorkout> sets) {
    var ids = orderSets;

    if (ids.length == 0) for (final set in sets) ids.add(set.id);
    if (next >= orderSets.length) next = orderSets.length - 1;

    final item = ids.removeAt(prev);
    ids.insert(next, item);

    setState(() {
      orderSets = ids;
    });
  }

  Widget buildSet(SetWorkout set, List<SetWorkout> sets) => InkWell(
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
          if (sortMode) return;
          if (!delitionMode) return showSetDetails(setId: set.id, sets: sets);

          selectItemHandler(set);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: WorkoutItem(
            isSortMode: sortMode,
            delitionMode: delitionMode,
            isSelected: selectedSets.contains(set),
            onViewComment: (rep) => viewCommentHandler(rep, set),
            set: set,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WorkOutScreenService(
      context: context,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: (delitionMode | sortMode)
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
                            Navigator.of(context).pushNamed(
                                BodyPartsScreen.routeName,
                                arguments: {"pushed": true});
                          }),
                      Container(
                          child: IconDropDown(
                        icons: [
                          Icon(analysisMode ? Icons.reorder : Icons.timeline),
                          // Icon(Icons.view_agenda
                          // Icon(Icons.settings),
                        ],
                        backgroundColor: Theme.of(context).colorScheme.analysis,
                        iconColor: Colors.white,
                        onChange: (index) {
                          if (index == 0) {
                            setState(() {
                              analysisMode = !analysisMode;
                            });
                          }
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
                  child: AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, _) => Transform.translate(
                      offset: Offset(0.0 * (direction ? 1 : -1), 0.0),
                      child: BlocBuilder<WorkoutBloc, WorkoutState>(
                        builder: (context, state) {
                          if (state is WorkoutSets) {
                            return StreamBuilder(
                              builder: (context, sts) {
                                if (sts.connectionState ==
                                    ConnectionState.active) {
                                  List<SetWorkout> sets = sts.data;

                                  sets.sort((a, b) => orderSets
                                      .indexOf(a.id)
                                      .compareTo(orderSets.indexOf(b.id)));
                                  if (sets.isEmpty)
                                    return WorkoutEmpty(
                                      currentDate: state.date,
                                    );

                                  if (analysisMode)
                                    return WorkoutAnalysisScreen(sets);

                                  return !sortMode
                                      ? ListView.builder(
                                          itemCount: sets.length,
                                          itemBuilder: (context, i) =>
                                              buildSet(sets[i], sets),
                                        )
                                      : ReorderableListView(
                                          onReorder: (prev, next) =>
                                              orderSetsHandler(
                                                  prev, next, sets),
                                          children: [
                                              for (final set in sets)
                                                buildSet(set, sets)
                                            ]
                                          // itemCount: sets.length,
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
            )),
      ),
    );
  }
}
