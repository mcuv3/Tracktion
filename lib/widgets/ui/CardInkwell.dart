import 'package:flutter/material.dart';
import 'package:tracktion/colors/constants.dart';

class CardInkwell extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final Widget child;

  CardInkwell(this.child, {this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      decoration: BoxDecoration(
        boxShadow: shadowList,
        borderRadius: BorderRadius.circular(5),
        color: Colors.red,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: InkWell(
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.05),
          splashFactory: InkSplash.splashFactory,
          child: child,
        ),
      ),
    );
  }
}
