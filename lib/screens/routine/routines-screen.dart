import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/screens/exercise/body-parts-screen.dart';
import 'package:tracktion/widgets/forms/SaveSetRoutine.dart';
import 'package:tracktion/widgets/items/RoutineItem.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';

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

  void saveSetRoutineHandler() async {
    final exercise = await Navigator.of(context)
            .pushNamed(BodyPartsScreen.routeName, arguments: {"readOnly": true})
        as Exercise;

    if (exercise == null) return;

    final setRoutine = await showAnimatedModal(
        context,
        SaveSetRoutineForm(
          exercise: exercise,
        ));
  }

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
              onPressed: saveSetRoutineHandler,
            ),
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
