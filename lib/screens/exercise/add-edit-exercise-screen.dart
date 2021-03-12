import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/difficulties.dart';
import 'package:tracktion/models/app/exercise.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/create-exercise.dart';
import 'package:tracktion/util/showMessage.dart';
import 'package:tracktion/util/showModalConfirmation.dart';
import 'package:tracktion/widgets/StackAppBar.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/inputs/Select.dart';
import 'package:tracktion/widgets/inputs/input.dart';

import '../../colors/custom_colors.dart';
import '../index.dart';

class AddEditBodyPartsScreen extends StatefulWidget {
  static const routeName = '/exercise/create';

  @override
  _AddEditBodyPartsScreenState createState() => _AddEditBodyPartsScreenState();
}

class _AddEditBodyPartsScreenState extends State<AddEditBodyPartsScreen> {
  List<Map<String, dynamic>> bodyParts = BodyPartEnum.values.map((b) {
    return {"body": b, "active": false};
  }).toList();
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final form = GlobalKey<FormState>();
  var difficulty = Difficulty.Easy;
  var editMode = false;
  Exercise exe;
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      isInit = false;
      final props =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      if (props == null) return;
      this.exe = props["exe"];
      if (this.exe != null) {
        this.editMode = true;
        this.bodyParts = BodyPartEnum.values.map((b) {
          return {"body": b, "active": exe.bodyParts.any((e) => e == b)};
        }).toList();
        this.difficulty = exe.difficulty;
        this.nameController.text = exe.name;
        this.notesController.text = exe.notes;
      }
    }
  }

  validateInput(String val) {
    if (val == "") return 'This field is required';
    if (val.length < 5) return 'The value is too short';
    return null;
  }

  void deleteHandler() async {
    final delete = await showModalConfirmation(
        context: context,
        contentText: "This exercise will delete from all your workouts.",
        confirmText: 'Delete me');
    if (!delete) return;
    BlocProvider.of<ExerciseBloc>(context).add(DeleteExe(exe));
  }

  GestureDetector bodyPartPicker(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bodyParts[i]['active'] = !bodyParts[i]['active'];
        });
      },
      child: BodyPartWidget(
        bodyParts[i]['body'],
        active: bodyParts[i]['active'],
      ),
    );
  }

  void exerciseSuccessHandler(BuildContext ctx) {
    FocusScope.of(context).unfocus();
    if (!editMode) {
      nameController.text = "";
      notesController.text = "";
      setState(() {
        difficulty = Difficulty.Easy;
        bodyParts = bodyParts.map((e) {
          e['active'] = false;
          return e;
        }).toList();
      });
    }
    showSuccessMessage(
        context: ctx,
        message: editMode ? "Successfully Edited" : 'Successfully Created.');
  }

  void submit(BuildContext ctx) {
    List<BodyPartEnum> parts = [];

    if (!form.currentState.validate()) return;

    bodyParts.forEach((b) {
      if (b["active"]) parts.add(b["body"]);
    });

    if (parts.length == 0) {
      showErrorMessage(
          context: ctx, message: 'Body parts or difficulty missing.');
      return;
    }

    exe = Exercise(
        id: exe == null ? null : exe.id,
        lastWorkouts: editMode ? exe.lastWorkouts : [],
        maxVolumeSetId: editMode ? exe.maxVolumeSetId : null,
        maxWeigthSetId: editMode ? exe.maxWeigthSetId : null,
        maxVolume: editMode ? exe.maxVolume : null,
        maxWeigth: editMode ? exe.maxWeigth : null,
        bodyParts: parts,
        difficulty: difficulty,
        notes: notesController.text,
        name: nameController.text);

    if (editMode && exe.id != null) {
      BlocProvider.of<ExerciseBloc>(context).add(EditExe(exe));
    } else {
      BlocProvider.of<ExerciseBloc>(context).add(CreateExe(exe));
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return Scaffold(
        body: Stack(
          children: [
            AbstractShape(
              width: double.infinity,
              height: query.size.height,
              shape:
                  CreateExerciseShape(Theme.of(context).colorScheme.routines),
            ),
            StackAppBar(
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 35,
                  ),
                  onPressed: deleteHandler,
                )
              ],
            ),
            Form(
              key: form,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Text('Body Part',
                          style: Theme.of(context).textTheme.headline6),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => bodyPartPicker(i),
                          itemCount: bodyParts.length,
                        ),
                      ),
                      TracktionInput(
                        controller: nameController,
                        hint: 'Exercise name',
                        validator: (val) {
                          if (val.length <= 3) {
                            return 'Name too short';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Select<Difficulty>(
                        options: Difficulty.values,
                        value: difficulty,
                        onSelect: (val) {
                          setState(() {
                            difficulty = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TracktionInput(
                        controller: notesController,
                        hint: 'Notes ..',
                        maxlines: 5,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: BlocListener<ExerciseBloc, ExerciseState>(
          listener: (ctx, state) {
            if (state is ExerciseCreatedSuccess) {
              exerciseSuccessHandler(ctx);
            }
            if (state is ExerciseFailure) {
              showErrorMessage(context: ctx, message: state.message);
            }
            if (state is ExerciseDeleteSuccess) {
              Navigator.popUntil(
                  context, ModalRoute.withName(SearchExercise.routeName));
            }
          },
          child: Builder(
            builder: (ctx) => Padding(
              padding: EdgeInsets.all(8),
              child: TextButton.icon(
                onPressed: () => submit(ctx),
                icon: Icon(Icons.save,
                    color: Theme.of(context).colorScheme.exercise),
                label: Text('Save',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.exercise)),
              ),
            ),
          ),
        ));
  }
}
