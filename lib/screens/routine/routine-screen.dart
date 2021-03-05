import 'package:flutter/material.dart';
import 'package:tracktion/widgets/items/SetRoutineItem.dart';

class RoutineScreen extends StatelessWidget {
  static const routeName = "/routine-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sets"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemBuilder: (context, i) => SetRoutineItem(
                      onTap: () {},
                    ))));
  }
}
