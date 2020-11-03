import 'package:flutter/material.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/screens/add-edit-exercise.dart';
import 'package:tracktion/screens/search-exercise.dart';
import 'package:tracktion/widgets/body-part.dart';
import '../colors/custom_colors.dart';

class ExerciseScreen extends StatelessWidget {
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('Body Parts',
              style: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 8, //vertical spacing
                    runSpacing: 8, //horizontal spacing
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: BodyPart.values
                        .map((bdy) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  SearchExercise.routeName,
                                  arguments: bdy);
                            },
                            child: Hero(tag: bdy, child: BodyPartWidget(bdy))))
                        .toList(),
                  ),
                ],
              ),
            ))
          ],
        )),
        floatingActionButton: FlatButton.icon(
          colorBrightness: Brightness.light,
          padding: EdgeInsets.all(8),
          onPressed: () {
            Navigator.of(context).pushNamed(AddEditExerciseScreen.routeName);
          },
          icon: Icon(Icons.add),
          label: Text('Add Exercise'),
          textColor: Colors.white,
          color: Theme.of(context).colorScheme.exercise,
        ));
  }
}
