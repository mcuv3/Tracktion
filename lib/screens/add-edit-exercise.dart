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
import '../colors/custom_colors.dart';

class AddEditExerciseScreen extends StatefulWidget {
  static const routeName = '/exercise/create';

  @override
  _AddEditExerciseScreenState createState() => _AddEditExerciseScreenState();
}

class _AddEditExerciseScreenState extends State<AddEditExerciseScreen> {
  final Map<String, String> exerciseInputs = {};
  List<Map<String, dynamic>> bodyParts = [];
  final form = GlobalKey<FormState>();
  List<BodyPart> bds = [];
  var difficulty = 'Difficulty';
  BuildContext _ctx;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Exercise exs = ModalRoute.of(context).settings.arguments;
    if (exs != null) {
      bds = exs.bodyParts;
      difficulty = enumToString(exs.difficulty);
      exerciseInputs["name"] = exs.name;
    }
  }

  @override
  void initState() {
    super.initState();

    this.bodyParts = BodyPart.values.map((b) {
      return {"body": b, "active": false};
    }).toList();
  }

  validateInput(String val) {
    if (val == "") return 'This field is required';
    if (val.length < 5) return 'The value is too short';
    return null;
  }

  void changeHandler(String val, String field) {
    setState(() {
      exerciseInputs[field] = val;
    });
  }

  void submit(BuildContext ctx) {
    List<BodyPart> parts = [];

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
      }

      if (parts.length == 0 || difficulty == "Difficulty") {
        final snackBar = SnackBar(
            content: Text('Body parts or difficulty missing.'),
            backgroundColor: Theme.of(ctx).colorScheme.routines);
        Scaffold.of(ctx).showSnackBar(snackBar);
        return;
      }

      final exe = Exercise(
          id: 0,
          bodyParts: parts,
          difficulty: dt,
          notes: exerciseInputs["notes"],
          name: exerciseInputs["name"]);

      BlocProvider.of<ExerciseBloc>(context).add(CreateExe(exe));
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
              form.currentState.reset();
              FocusScope.of(context).unfocus();
              setState(() {
                difficulty = 'Difficulty';
                bodyParts = bodyParts.map((e) {
                  e['active'] = false;
                  return e;
                }).toList();
              });
              final snackBar = SnackBar(
                  content: Text('Successfully Created.'),
                  backgroundColor: Theme.of(ctx).colorScheme.analysis);
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
