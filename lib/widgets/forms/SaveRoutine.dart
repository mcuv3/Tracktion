import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/routine-group/routine_bloc.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class SaveRoutineForm extends StatefulWidget {
  @override
  _SaveRoutineFormState createState() => _SaveRoutineFormState();
}

class _SaveRoutineFormState extends State<SaveRoutineForm> {
  final form = GlobalKey<FormState>();

  final fields = {};
  var level = Level.Normal;

  String isRequired(String value) {
    if (value == "") return "Field must be set.";
    return null;
  }

  void onSubmit() {
    var isValid = form.currentState.validate();

    if (isValid) {
      print(fields);
      BlocProvider.of<RoutineGroupBloc>(context).add(SaveGroupRoutine(
          RoutineGroupData(
              id: null,
              name: fields["name"],
              description: fields["description"],
              imageUrl: "test",
              level: level)));
    }
  }

  void changeHandler(String key, String value) {
    fields[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.analysis),
              child: Text("What about pull.",
                  style: TextStyle(fontSize: 18, color: Colors.white))),
          Divided(
              leftWidget: Text("Name"),
              rightWidget: TracktionInput(
                initialValue: "...",
                hint: "",
              )),
          SaveFormActions(onCancel: () {}, onSave: () {})
        ],
      ),
    );
  }
}
