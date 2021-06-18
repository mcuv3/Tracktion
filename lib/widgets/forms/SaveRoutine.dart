import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/NumericSelector.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class SaveRoutineForm extends StatefulWidget {
  final int groupId;
  final RoutineData routine;

  SaveRoutineForm({@required this.groupId, this.routine});

  @override
  _SaveRoutineFormState createState() => _SaveRoutineFormState();
}

class _SaveRoutineFormState extends State<SaveRoutineForm> {
  var fields = {"name": "", "notes": ""};
  var duration = 60;
  var form = GlobalKey<FormState>();
  var difficultyRequired = false;
  Difficulty difficulty;

  @override
  void initState() {
    super.initState();
    if (widget.routine == null) return;

    fields["name"] = widget.routine.name;
    fields["notes"] = widget.routine.notes;
    duration = widget.routine.duration;
    difficulty = widget.routine.difficulty;
  }

  String isRequired(String value) {
    if (value == "") return "Field must be set.";
    return null;
  }

  void onSubmit() {
    if (!form.currentState.validate()) return;

    if (difficulty == null) {
      setState(() {
        difficultyRequired = true;
      });
      return;
    }

    final routine = RoutineData(
        id: widget.routine == null ? null : widget.routine.id,
        groupId: widget.groupId,
        difficulty: difficulty,
        name: fields["name"],
        duration: duration,
        notes: fields["notes"]);
    Navigator.of(context).pop(routine);
  }

  void changeHandler(String key, String value) {
    fields[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.maxFinite,
      child: Form(
        key: form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.analysis),
                  child: Text("New Routine",
                      style: TextStyle(fontSize: 18, color: Colors.white))),
              Divided(
                  leftWidget: Text("Name"),
                  rightWidget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TracktionInput(
                      align: TextAlign.center,
                      initialValue: fields["name"],
                      errorColor: Theme.of(context).colorScheme.routines,
                      validator: (value) {
                        if (value.isEmpty) return "Name is required";
                        return null;
                      },
                      change: (v) => setState(() {
                        fields["name"] = v;
                      }),
                      hint: "Pull #1",
                    ),
                  )),
              Divided(
                  leftWidget: Text("Duration"),
                  rightWidget: NumericSelector(
                    value: "$duration min",
                    onPress: (v) {
                      if (duration <= 0) return;
                      setState(() {
                        duration = v == "left" ? duration - 5 : duration + 5;
                      });
                    },
                  )),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.analysis),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontFamily: "CarterOne"),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Difficulty",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          if (difficultyRequired)
                            TextSpan(
                                text: "\t\tis required.",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .routinesLight)),
                        ]),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Difficulty.values
                      .map((e) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: e,
                                activeColor:
                                    Theme.of(context).colorScheme.routines,
                                groupValue: difficulty,
                                onChanged: (val) {
                                  setState(() {
                                    difficulty = val;
                                    if (difficultyRequired) {
                                      difficultyRequired = false;
                                    }
                                  });
                                },
                              ),
                              Text(enumToString(e),
                                  style: TextStyle(fontSize: 13))
                            ],
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.analysis),
                  child: Text("Notes",
                      style: TextStyle(fontSize: 18, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TracktionInput(
                  maxlines: 3,
                  errorColor: Theme.of(context).colorScheme.routines,
                  change: (v) => setState(() {
                    fields["notes"] = v;
                  }),
                  initialValue: fields["notes"],
                ),
              ),
              SaveFormActions(
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onSave: onSubmit)
            ],
          ),
        ),
      ),
    );
  }
}
