import 'package:flutter/material.dart';

class TracktionGlobals extends InheritedWidget {
  TracktionGlobals({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  static TracktionGlobals of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TracktionGlobals>();
  }

  @override
  bool updateShouldNotify(TracktionGlobals oldWidget) {
    return true;
  }
}
