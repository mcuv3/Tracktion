import 'package:flutter/material.dart';

class StackAppBar extends StatelessWidget {
  const StackAppBar(
      {Key key, @required this.actions, this.iconColor = Colors.black})
      : super(key: key);
  final List<Widget> actions;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: actions,
          backgroundColor: Colors.transparent,
          floating: false,
          backwardsCompatibility: false,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
