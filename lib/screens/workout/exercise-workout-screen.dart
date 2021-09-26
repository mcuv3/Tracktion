import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/bloc/exercise-stream/exercisestream_cubit.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/exercise.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/rep.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/add-exercise.dart';
import 'package:tracktion/widgets/StackAppBar.dart';
import 'package:tracktion/widgets/items/TracktionCalendar.dart';
import 'package:tracktion/widgets/items/TracktionHeader.dart';
import 'package:tracktion/widgets/items/reps-item.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/modals/RepInputs.dart';
import 'package:tracktion/widgets/modals/shouldSave.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/streams/ExerciseStream.dart';
import 'package:tracktion/widgets/ui/TracktionButton.dart';

import '../../colors/custom_colors.dart';

class ExerciseWorkOut extends StatefulWidget {
  static const routeName = '/add-exercise-workout';

  @override
  _ExerciseWorkOutState createState() => _ExerciseWorkOutState();
}

class _ExerciseWorkOutState extends State<ExerciseWorkOut> {
  Exercise exs;
  List<Rep> reps = [];
  int setId;

  DateTime date =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  var init = false;
  var fromWorkout = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!init) {
      var initialState =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      if (initialState["reps"] != null) {
        reps = initialState["reps"];
      }

      setId = initialState["setId"];
      if (initialState["fromWorkout"] != null) fromWorkout = true;
      exs = initialState["exercise"] as Exercise;
      if (exs != null)
        BlocProvider.of<ExerciseStreamCubit>(context).streamExercise(exs.id);
      init = true;
    }
  }

  void addRepHandler() {
    var intialReps = 0;
    var rpe = 0;
    var weight = 0.0;

    if (reps.length > 0) {
      intialReps = reps[reps.length - 1].reps;
      weight = reps[reps.length - 1].weight;
      rpe = reps[reps.length - 1].rpe;
    }
    final rep =
        Rep(id: reps.length, reps: intialReps, rpe: rpe, weight: weight);
    setState(() {
      reps.add(rep);
    });
  }

  void changeCommentHandler(Rep rep, int i) async {
    var isNew = rep.notes == "";
    var updatedRep = await noteRepModal(context: context, rep: rep);
    setState(() {
      if (updatedRep == null && !isNew) {
        reps[i] = Rep(
            id: rep.id,
            notes: "",
            reps: rep.reps,
            rpe: rep.rpe,
            weight: rep.weight);
      } else if (updatedRep != null) {
        reps[i] = updatedRep;
      }
    });
  }

  void editRepHandler(Rep rep, int indexRep) async {
    var values = {
      "reps": rep.reps,
      "weight": rep.weight,
      "rpe": rep.rpe,
    };

    Rep newRep = await showAnimatedModal(context, WorkoutRepConfiguration(rep));
    setState(() {
      reps[indexRep] = newRep;
    });
  }

  void removeRepHandler(int index) {
    setState(() {
      reps.removeAt(index);
    });
  }

  Future<bool> onPopHandler() async {
    var noReps = reps.length == 0;

    if (noReps && !fromWorkout) return true;

    var _set = SetWorkout(
        id: setId, exercise: exs, reps: reps, maxWeigth: 0, volume: 0);

    if (fromWorkout && noReps) {
      var willDelete =
          await shouldSaveModal(context, "This set will be deleted.");
      if (willDelete) {
        BlocProvider.of<WorkoutBloc>(context).add(DeleteSet(_set));
        BlocProvider.of<WorkoutBloc>(context).add(UpdateWorkoutMetadata(
          exesIds: [exs.id],
          bodyParts: exs.bodyParts,
          type: RequestType.Create,
          workoutDate: date,
        ));
        return true;
      } else
        return false;
    }

    var shouldSave = await shouldSaveModal(context);
    if (shouldSave) {
      BlocProvider.of<WorkoutBloc>(context)
          .add(SaveSet(set: _set, date: date, isEdit: fromWorkout));
    }
    return true;
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: onPopHandler,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            AbstractShape(
              width: double.infinity,
              height: query.size.height,
              shape: ShapeAddExerciseUp(Theme.of(context).colorScheme.routines),
            ),
            AbstractShape(
              width: double.infinity,
              height: query.size.height,
              shape:
                  ShapeAddExerciseDown(Theme.of(context).colorScheme.exercise),
            ),
            StackAppBar(
              actions: [
                BlocBuilder<WorkoutBloc, WorkoutState>(
                  builder: (context, state) {
                    if (state is WorkoutSets) {
                      date = state.date;
                    }
                    return GestureDetector(
                      onTap: () async {
                        DateTime selectedDate =
                            await showCupertinoModalBottomSheet(
                          expand: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => TracktionCalendar(date),
                        );
                        if (selectedDate == null) return;

                        setState(() {
                          date = selectedDate;
                        });
                      },
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                          height: 10,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .exercise
                                      .withOpacity(0.8),
                                  width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(date),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .exercise
                                    .withOpacity(0.8)),
                          )),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.info,
                    color:
                        Theme.of(context).colorScheme.exercise.withOpacity(0.8),
                  ),
                  iconSize: 26,
                  onPressed: () {
                    showAnimatedModal(
                        context,
                        TracktionNotifyModal(
                          title: "Description",
                          type: NotifyType.Info,
                          description: exs.notes,
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit,
                      color: Theme.of(context)
                          .colorScheme
                          .exercise
                          .withOpacity(0.8)),
                  iconSize: 26,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        AddEditBodyPartsScreen.routeName,
                        arguments: {"exe": exs});
                  },
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: ExerciseStreamWidget(
                      onLoadExercise: (exe) {
                        exs = exe;
                      },
                    )),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: reps.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Text("No reps added.",
                                style: TextStyle(fontSize: 18)))
                        : ListView.builder(
                            itemCount: reps.length,
                            itemBuilder: (ctx, i) => Dismissible(
                              key: Key(reps[i].id.toString()),
                              onDismissed: (_) => removeRepHandler(i),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: RepItem(
                                  reps: reps[i].reps,
                                  weight: reps[i].weight,
                                  rpe: reps[i].rpe,
                                  isExpanded: true,
                                  onTap: () => editRepHandler(reps[i], i),
                                  actions: IconButton(
                                    visualDensity: VisualDensity.compact,
                                    icon: Icon(
                                      reps[i].notes != ""
                                          ? Icons.comment
                                          : Icons.insert_comment_outlined,
                                    ),
                                    onPressed: () =>
                                        changeCommentHandler(reps[i], i),
                                    color: Colors.red,
                                    padding: EdgeInsets.all(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                )
              ],
            )
          ]),
          floatingActionButton: TracktionButton(onPress: addRepHandler),
        ),
      ),
    );
  }
}
