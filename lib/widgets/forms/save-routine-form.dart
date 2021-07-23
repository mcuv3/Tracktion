import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart' as _;
import 'package:tracktion/bloc/routine-group/routine_bloc.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/widgets/inputs/Select.dart';
import 'package:tracktion/widgets/inputs/input.dart';

class SaveRoutineForm extends StatefulWidget {
  @override
  _SaveRoutineFormState createState() => _SaveRoutineFormState();
}

class _SaveRoutineFormState extends State<SaveRoutineForm> {
  final form = GlobalKey<FormState>();
  var level = Level.Beginner;
  final fields = {};

  String? isRequired(String? value) {
    if (value != null && value == "") return "Field must be set.";
    return null;
  }

  void onSubmit() {
    var isValid = form.currentState!.validate();
    if (isValid) {
      BlocProvider.of<RoutineGroupBloc>(context).add(SaveGroupRoutine(
          RoutineGroupCompanion(
              name: fields["name"],
              description: fields["description"],
              level: _.Value(level))));
    }
  }

  void changeHandler(String key, String? value) {
    fields[key] = value;
  }

  void successHandler() {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutineGroupBloc, RoutineGroupState>(
      listener: (context, state) {
        if (state is RoutinesGroupSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: form,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.analysis,
                    fontSize: 23),
              ),
              TracktionInput(
                validator: isRequired,
                autoFocus: true,
                hint: "Push Pull Legs",
                change: (val) => changeHandler("name", val),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.analysis,
                    fontSize: 23),
              ),
              TracktionInput(
                validator: isRequired,
                change: (val) => changeHandler("description", val),
                hint: "No pain no gain.",
                maxlines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Level",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.analysis,
                    fontSize: 23),
              ),
              SizedBox(
                height: 10,
              ),
              Select<Level>(
                  onSelect: (value) {
                    setState(() {
                      level = value;
                    });
                  },
                  options: Level.values,
                  value: level),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: onSubmit,
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.black),
                    child: Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
