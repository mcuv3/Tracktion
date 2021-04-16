import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/routine-group/routine_bloc.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/widgets/inputs/Select.dart';
import 'package:tracktion/widgets/inputs/input.dart';

class SaveGroupRoutineForm extends StatefulWidget {
  final RoutineGroupData group;

  SaveGroupRoutineForm([this.group]);
  @override
  _SaveGroupRoutineFormState createState() => _SaveGroupRoutineFormState();
}

class _SaveGroupRoutineFormState extends State<SaveGroupRoutineForm> {
  final form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  var level = Level.Normal;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      level = widget.group.level;
      nameController.text = widget.group.name;
      descriptionController.text = widget.group.description;
    });
  }

  String isRequired(String value) {
    if (value == "") return "Field must be set.";
    return null;
  }

  void onSubmit() {
    var isValid = form.currentState.validate();

    if (isValid) {
      BlocProvider.of<RoutineGroupBloc>(context).add(SaveGroupRoutine(
          RoutineGroupData(
              id: widget.group != null ? widget.group.id : null,
              name: nameController.text,
              description: descriptionController.text,
              imageUrl: "test",
              level: level)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutineGroupBloc, RoutineGroupState>(
      listener: (context, state) {
        if (state is RoutinesGroupSuccess) {
          Navigator.of(context).pop();
        }
        if (state is RoutineGroupFailure) {}
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
                controller: nameController,
                autoFocus: true,
                hint: "Push Pull Legs",
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
                controller: descriptionController,
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
              Select(
                onSelect: (val) {
                  setState(() {
                    level = val;
                  });
                },
                value: level,
                options: Level.values,
              ),
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
