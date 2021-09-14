import 'package:flutter/material.dart';
import "package:tracktion/colors/custom_colors.dart";

class TracktionButton extends StatelessWidget {
  final Function onPress;

  const TracktionButton({Key key, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Icon(Icons.add),
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.routines),
    );
  }
}
