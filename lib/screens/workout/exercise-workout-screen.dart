import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:tracktion/bloc/exercise-stream/exercisestream_cubit.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/models/app/exercise.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/rep.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/add-exercise.dart';
import 'package:tracktion/widgets/StackAppBar.dart';
import 'package:tracktion/widgets/items/reps-item.dart';
import 'package:tracktion/widgets/modals/NoteInput.dart';
import 'package:tracktion/widgets/modals/RepInputs.dart';
import 'package:tracktion/widgets/modals/shouldSave.dart';
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
  var date = DateTime.now();
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

  void editRepHandler(Rep rep, int indexRep) {
    repInputsModal(context, rep).then((repUpadated) {
      setState(() {
        reps[indexRep] = repUpadated;
      });
    });
  }

  void removeRepHandler(int index) {
    setState(() {
      reps.removeAt(index);
    });
  }

  Future<bool> onPopHandler() async {
    var shouldSave = true;
    var willDelete = reps.length == 0 && fromWorkout;

    if (!fromWorkout || willDelete)
      shouldSave = await shouldSaveModal(
          context, willDelete ? "This set will be deleted." : null);

    if (!shouldSave && willDelete) return false;

    if (shouldSave) {
      final set = SetWorkout(id: setId, exercise: exs, reps: reps);
      BlocProvider.of<WorkoutBloc>(context).add(SaveSet(set: set, date: date));
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
                  ShapeAddExerciseDown(Theme.of(context).colorScheme.analysis),
            ),
            StackAppBar(
              actions: [
                BlocBuilder<WorkoutBloc, WorkoutState>(
                  builder: (context, state) {
                    if (state is WorkoutSets) {
                      date = state.date;
                    }
                    return GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            initialDateTime: date, onConfirm: (date, ints) {
                          setState(() {
                            date = date;
                          });
                        },
                            pickerTheme: DateTimePickerTheme(
                                itemTextStyle:
                                    TextStyle(fontFamily: "CarterOne")));
                      },
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                          height: 10,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(date),
                            style: TextStyle(color: Colors.black),
                          )),
                    );
                  },
                ),
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
                              child: GestureDetector(
                                onTap: () => editRepHandler(reps[i], i),
                                child: RepItem(
                                  hasComment: reps[i].notes != "",
                                  reps: reps[i].reps,
                                  weight: reps[i].weight,
                                  rpe: reps[i].rpe,
                                  isExpanded: true,
                                  onPressIcon: () =>
                                      changeCommentHandler(reps[i], i),
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
