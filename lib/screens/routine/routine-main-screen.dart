import 'package:flutter/material.dart';

class RoutineMainScreen extends StatelessWidget {
  static const routeName = "/routine";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Routines"),
      ),
    );
  }
}
