import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart' as modelsApp;
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/NumericSelector.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class SaveSetRoutineForm extends StatefulWidget {
  final modelsApp.Exercise exercise;
  final int routineId;
  final RoutineSetData set;
  SaveSetRoutineForm(
      {Key key, @required this.exercise, @required this.routineId, this.set})
      : super(key: key);

  @override
  _SaveSetRoutineFormState createState() => _SaveSetRoutineFormState();
}

class _SaveSetRoutineFormState extends State<SaveSetRoutineForm>
    with TickerProviderStateMixin {
  CopyMethod method;
  var rpe = 8;
  var invalidMethod = false;
  var invalidMr = false;
  var exerciseName = "";

  final mrController = TextEditingController(text: "0.0");
  var numSeries = 3;

  final Map<String, String> copyMethods = {
    "Smart":
        "Base of your prevous workouts with this exercise we provide al list of sets of reps intelligentlly selected for to make progress week by week."
            "",
    "Static":
        "Provide a number of sets that will be copied every time you select this routine, you can provide a RPE target as well.",
    "Previus":
        "Every time you select this routine the most recent and previous set of this exercise  will be copied. ",
    "Percentage":
        "For compund exercise like Squat or Deadlift this option allow you to set a percentage target base of your 1MR(Max Repetition) every time you select this routine it will propump with the required value, note that can provide 1MR for flexibility.",
  };

  @override
  void initState() {
    super.initState();
    if (widget.set == null) {
      exerciseName = widget.exercise.name;
      return;
    }

    exerciseName = widget.set.exerciseName;
    rpe = widget.set.targetRpe;
    method = widget.set.copyMethod;

    if (method == CopyMethod.Percentage)
      mrController.value = TextEditingValue(text: widget.set.repmax.toString());

    if (method == CopyMethod.Static) numSeries = widget.set.series;
  }

  void showDetails(CopyMethod copyMethod) {
    showAnimatedModal(
        context,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            buildHeader(enumToString(copyMethod)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                copyMethods[enumToString(copyMethod)],
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ));
  }

  void submit() {
    final mr = double.tryParse(mrController.text);

    if (method == null) {
      setState(() {
        invalidMethod = true;
      });
      return;
    }

    if (method == CopyMethod.Percentage && (mr == null || mr == 0.0)) {
      setState(() {
        invalidMr = true;
      });
      return;
    }

    final setRoutine = RoutineSetData(
        id: widget.set == null ? null : widget.set.id,
        copyMethod: method,
        notes: "",
        exerciseId:
            widget.exercise != null ? widget.exercise.id : widget.set.id,
        exerciseName: widget.exercise != null
            ? widget.exercise.name
            : widget.set.exerciseName,
        routineId: widget.routineId,
        targetRpe: rpe,
        series: method == CopyMethod.Static ? numSeries : null,
        repmax: method == CopyMethod.Percentage ? mr : null);

    Navigator.of(context).pop(setRoutine);
  }

  Container buildHeader(String text, [Color color = Colors.white]) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.analysis),
        child: Text(text, style: TextStyle(fontSize: 18, color: color)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(exerciseName),
          ...ListTile.divideTiles(
              context: context,
              color: Theme.of(context).colorScheme.analysis.withOpacity(0.8),
              tiles: CopyMethod.values
                  .map((e) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(4),
                        leading: Radio(
                          activeColor: Colors.red,
                          fillColor: MaterialStateProperty.all(
                              invalidMethod ? Colors.red : Colors.black),
                          value: e,
                          groupValue: method,
                          onChanged: (v) {
                            setState(() {
                              method = v;
                              if (invalidMethod) {
                                invalidMethod = false;
                              }
                            });
                          },
                        ),
                        title: Text(enumToString(e),
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    invalidMethod ? Colors.red : Colors.black)),
                        trailing: IconButton(
                          color: Theme.of(context).colorScheme.analysis,
                          icon: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: Theme.of(context).colorScheme.analysisLight,
                          ),
                          onPressed: () {
                            showDetails(e);
                          },
                        ),
                      ))
                  .toList()),
          buildHeader("Configuration"),
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            child: Container(
              height: method == CopyMethod.Smart ||
                      method == CopyMethod.Previus ||
                      method == null
                  ? 60
                  : 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divided(
                        spaceA: 1,
                        spaceB: 1,
                        leftWidget: Text("RPE",
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .exercise
                                    .withOpacity(0.7))),
                        rightWidget: NumericSelector(
                            value: rpe,
                            onPress: (direction) {
                              setState(() {
                                var newRpe =
                                    direction == "left" ? rpe - 1 : rpe + 1;
                                if (newRpe < 1 || newRpe > 10) return;
                                rpe = newRpe;
                              });
                            })),
                    if (method == CopyMethod.Static)
                      Divided(
                          spaceA: 1,
                          spaceB: 1,
                          leftWidget: Text("# Series",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .exercise
                                      .withOpacity(0.7))),
                          rightWidget: NumericSelector(
                              value: numSeries,
                              onPress: (direction) {
                                setState(() {
                                  if (numSeries <= 1 && direction == "left")
                                    return;
                                  numSeries = direction == "left"
                                      ? numSeries - 1
                                      : numSeries + 1;
                                });
                              })),
                    if (method == CopyMethod.Percentage)
                      Divided(
                          spaceA: 1,
                          spaceB: 1,
                          leftWidget: Text("1 MR",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: invalidMr
                                      ? Colors.red
                                      : Theme.of(context)
                                          .colorScheme
                                          .exercise
                                          .withOpacity(0.7))),
                          rightWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TracktionInput(
                              keyboardType: TextInputType.number,
                              controller: mrController,
                              validator: (v) {
                                final value = double.tryParse(v);
                                if (value == null || value < 0.0)
                                  return "Ivalid number.";

                                return null;
                              },
                              change: (value) {
                                final parsed = double.tryParse(value);
                                if (parsed != null &&
                                    parsed > 0.0 &&
                                    invalidMr) {
                                  setState(() {
                                    invalidMr = false;
                                  });
                                }
                              },
                              hint: "0.0",
                              align: TextAlign.center,
                            ),
                          )),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ),
          ),
          SaveFormActions(
            onCancel: () {
              Navigator.of(context).pop();
            },
            onSave: submit,
          ),
        ],
      ),
    );
  }
}