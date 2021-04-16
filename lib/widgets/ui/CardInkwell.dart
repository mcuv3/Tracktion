import 'package:flutter/material.dart';

class CardInkwell extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final Widget child;

  CardInkwell(this.child, {this.onTap,this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.2),
          splashFactory: InkSplash.splashFactory,
          child: child,
        ),
      ),
    );
  }
}
