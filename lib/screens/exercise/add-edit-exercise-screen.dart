import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/difficulties.dart';
import 'package:tracktion/models/exercise.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/create-exercise.dart';
import 'package:tracktion/util/difficulty.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/input.dart';
import '../../colors/custom_colors.dart';

class AddEditBodyPartsScreen extends StatefulWidget {
  static const routeName = '/exercise/create';

  @override
  _AddEditBodyPartsScreenState createState() => _AddEditBodyPartsScreenState();
}

class _AddEditBodyPartsScreenState extends State<AddEditBodyPartsScreen> {
  Map<String, String> exerciseInputs = {};
  List<Map<String, dynamic>> bodyParts = BodyPartEnum.values.map((b) {
    return {"body": b, "active": false};
  }).toList();
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final form = GlobalKey<FormState>();
  var difficulty = 'Difficulty';
  var editMode = false;
  void Function(Exercise) editExerciseSuccessfulCallBack;
  Exercise exe;
  BuildContext _ctx;
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
      this.editExerciseSuccessfulCallBack = props["updateCallBack"];
      if (this.exe != null) {
        this.editMode = true;
        this.bodyParts = BodyPartEnum.values.map((b) {
          return {"body": b, "active": exe.bodyParts.any((e) => e == b)};
        }).toList();
        this.difficulty = enumToString(exe.difficulty);
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

  void _deleteHandler() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(20),
              content:
                  Text("This exercise will delete from all your workouts."),
              actions: <Widget>[
                FlatButton(
                  color: Theme.of(context).colorScheme.exercise,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  color: Theme.of(context).colorScheme.routines,
                  child: Text(
                    'Delete me',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void changeHandler(String val, String field) {
    setState(() {
      exerciseInputs[field] = val;
    });
  }

  void submit(BuildContext ctx) {
    List<BodyPartEnum> parts = [];

    if (form.currentState.validate()) {
      bodyParts.forEach((b) {
        if (b["active"]) parts.add(b["body"]);
      });
      var dt = Difficulty.Easy;
      switch (difficulty) {
        case "Easy":
          dt = Difficulty.Easy;
          break;
        case "Easy":
          dt = Difficulty.Normal;
          break;
        case "Hard":
          dt = Difficulty.Hard;
          break;
        case "Pro":
          dt = Difficulty.Pro;
          break;
        default:
          dt = null;
          break;
      }

      if (parts.length == 0 || dt == null) {
        final snackBar = SnackBar(
            content: Text('Body parts or difficulty missing.'),
            backgroundColor: Theme.of(ctx).colorScheme.routines);
        Scaffold.of(ctx).showSnackBar(snackBar);
        return;
      }

      exe = Exercise(
          id: exe == null ? null : exe.id,
          bodyParts: parts,
          difficulty: dt,
          notes: notesController.text,
          name: nameController.text);

      if (editMode && exe.id != null) {
        BlocProvider.of<ExerciseBloc>(context).add(EditExe(exe));
      } else {
        BlocProvider.of<ExerciseBloc>(context).add(CreateExe(exe));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: AbstractShape(
                width: double.infinity,
                height: query.size.height,
                shape:
                    CreateExerciseShape(Theme.of(context).colorScheme.routines),
              ),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            size: 35,
                          ),
                          onPressed: _deleteHandler,
                        ))
                  ],
                  backgroundColor: Colors.transparent,
                  floating: true,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Form(
              key: form,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Body Part', style: Theme.of(context).textTheme.title),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            setState(() {
                              bodyParts[i]['active'] = !bodyParts[i]['active'];
                            });
                          },
                          child: BodyPartWidget(
                            bodyParts[i]['body'],
                            active: bodyParts[i]['active'],
                          ),
                        ),
                        itemCount: bodyParts.length,
                      ),
                    ),
                    TracktionInput(
                      controller: nameController,
                      hint: 'Exercise name',
                      change: (v) => changeHandler(v, 'name'),
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
                    GestureDetector(
                      onTap: () {
                        showDifficulties(
                            cb: (val) {
                              setState(() {
                                difficulty = enumToString(val);
                              });
                            },
                            context: context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.black45, width: 1)),
                        child: Row(
                          children: [
                            Text(difficulty,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16)),
                            Icon(Icons.expand_more)
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TracktionInput(
                      controller: notesController,
                      hint: 'Notes ..',
                      maxlines: 5,
                      change: (v) => changeHandler(v, 'notes'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: BlocListener<ExerciseBloc, ExerciseState>(
          listener: (ctx, state) {
            if (state is ExerciseCreatedSuccess) {
              FocusScope.of(context).unfocus();
              if (!editMode) {
                nameController.text = "";
                notesController.text = "";

                setState(() {
                  difficulty = 'Difficulty';
                  bodyParts = bodyParts.map((e) {
                    e['active'] = false;
                    return e;
                  }).toList();
                });
              } else {
                editExerciseSuccessfulCallBack(exe);
              }

              final snackBar = SnackBar(
                  content: Text(editMode
                      ? "Successfully Edited"
                      : 'Successfully Created.'),
                  backgroundColor: Theme.of(ctx).colorScheme.routines);
              Scaffold.of(ctx).showSnackBar(snackBar);
            }
            if (state is ExerciseFailure) {
              final snackBar = SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(ctx).colorScheme.routines);
              Scaffold.of(ctx).showSnackBar(snackBar);
            }
          },
          child: Builder(
            builder: (ctx) => FlatButton.icon(
              colorBrightness: Brightness.light,
              padding: EdgeInsets.all(8),
              onPressed: () => submit(ctx),
              icon: Icon(Icons.save),
              label: Text('Save'),
              textColor: Colors.white,
              color: Theme.of(context).colorScheme.exercise,
            ),
          ),
        ));
  }
}
