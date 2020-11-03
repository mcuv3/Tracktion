import 'package:flutter/material.dart';
import 'package:tracktion/models/body-parts.dart';
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
  var difficulty = 'Difficulty';

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
                  // Make the initial height of the SliverAppBar larger than normal.
                ),
              ],
            ),
            Padding(
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
                          border: Border.all(color: Colors.black45, width: 1)),
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
            )
          ],
        ),
        floatingActionButton: FlatButton.icon(
          colorBrightness: Brightness.light,
          padding: EdgeInsets.all(8),
          onPressed: () {},
          icon: Icon(Icons.save),
          label: Text('Save'),
          textColor: Colors.white,
          color: Theme.of(context).colorScheme.exercise,
        ));
  }
}
