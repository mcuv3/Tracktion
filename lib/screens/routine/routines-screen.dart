import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/widgets/items/RoutineItem.dart';

class RoutinesScreen extends StatefulWidget {
  static const routeName = "/----";

  const RoutinesScreen({Key key}) : super(key: key);

  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal Page'),
        actions: [
          IconButton(
              visualDensity: VisualDensity.compact,
              icon: FaIcon(FontAwesomeIcons.plusCircle),
              onPressed: () {}),
          IconButton(
              visualDensity: VisualDensity.compact,
              icon: FaIcon(FontAwesomeIcons.ellipsisV),
              onPressed: () {}),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.all(10),
          child: ListView.separated(
              itemBuilder: (context, i) => RoutineItem(),
              separatorBuilder: (context, i) => SizedBox(
                    height: 15,
                  ),
              itemCount: 6),
        ),
      ),
    );
  }
}
