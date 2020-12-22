import 'package:flutter/material.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/widgets/drawer.dart';
import './add-edit-exercise-screen.dart';
import './search-exercise-screen.dart';
import 'package:tracktion/widgets/body-part.dart';
import '../../colors/custom_colors.dart';

class BodyPartsScreen extends StatelessWidget {
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          // automaticallyImplyLeading: false,
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
                    children: BodyPartEnum.values
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
            Navigator.of(context).pushNamed(AddEditBodyPartsScreen.routeName);
          },
          icon: Icon(Icons.add),
          label: Text('Add Exercise'),
          textColor: Colors.white,
          color: Theme.of(context).colorScheme.exercise,
        ));
  }
}
