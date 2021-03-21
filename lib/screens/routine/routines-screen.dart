import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/widgets/items/RoutineItem.dart';

class RoutinesService extends InheritedWidget {
  RoutinesService({Key key, this.child, this.editMode})
      : super(key: key, child: child);

  final Widget child;
  final bool editMode;

  static RoutinesService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RoutinesService>();
  }

  @override
  bool updateShouldNotify(RoutinesService oldWidget) {
    return true;
  }
}

class RoutinesScreen extends StatefulWidget {
  static const routeName = "/----";

  const RoutinesScreen({Key key}) : super(key: key);

  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  var editMode = false;

  @override
  Widget build(BuildContext rootContext) {
    return RoutinesService(
      editMode: editMode,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modal Page'),
          actions: [
            IconButton(
                visualDensity: VisualDensity.compact,
                icon: FaIcon(FontAwesomeIcons.plusCircle),
                onPressed: () {}),
            IconButton(
                visualDensity: VisualDensity.compact,
                icon: FaIcon(FontAwesomeIcons.edit),
                onPressed: () {
                  setState(() {
                    editMode = !editMode;
                  });
                }),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            margin: EdgeInsets.all(10),
            child: ListView.separated(
                itemBuilder: (context, i) => RoutineItem(
                      key: Key(i.toString()),
                      onTap: () {},
                    ),
                separatorBuilder: (context, i) => SizedBox(
                      height: 15,
                    ),
                itemCount: 6),
          ),
        ),
      ),
    );
  }
}
