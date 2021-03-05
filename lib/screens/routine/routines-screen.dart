import 'package:flutter/material.dart';
import 'package:tracktion/screens/routine/routine-screen.dart';
import 'package:tracktion/widgets/items/RoutineItem.dart';

class RoutinesScreen extends StatelessWidget {
  static const routeName = "/routines-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Routines"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Expanded(
              child: ListView.builder(
                  itemBuilder: (context, i) => RoutineItem(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RoutineScreen.routeName);
                        },
                      )),
            )));
  }
}
