import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

class TracktionButton extends StatelessWidget {
  final Function onPress;

  const TracktionButton({Key key, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.analysis,
            Theme.of(context).colorScheme.routines
          ],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
      ),
      child: TextButton(
        child: Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ),
        onPressed: onPress,
      ),
    );
  }
}
