import 'package:flutter/material.dart';

class RoutineItem extends StatelessWidget {
  final Function()? onTap;
  RoutineItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0),
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.red,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.2),
          splashFactory: InkSplash.splashFactory,
          child: ClipRRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Text('Pull #1'), Icon(Icons.expand)],
            ),
          ),
        ),
      ),
    );
  }
}
