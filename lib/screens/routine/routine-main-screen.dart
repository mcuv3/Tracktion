import 'package:flutter/material.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/widgets/items/GroupRoutineItem.dart';

class RoutineMainScreen extends StatelessWidget {
  static const routeName = "/routine-main";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Group Routines"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, i) => GroupRoutineItem(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RoutinesScreen.routeName);
                      },
                      index: i,
                    ))));
  }
}
