import 'package:flutter/material.dart';
import 'package:tracktion/widgets/forms/save-routine-form.dart';

class SaveRoutineGroupScreen extends StatelessWidget {
  const SaveRoutineGroupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SaveRoutineForm(),
    );
  }
}
