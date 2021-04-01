import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/routine/routine_bloc.dart';
import 'package:tracktion/bloc/routines/routines_bloc.dart';
import 'package:tracktion/models/app/index.dart' as app;
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/screens/exercise/body-parts-screen.dart';
import 'package:tracktion/widgets/forms/SaveRoutine.dart';
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
        as app.Exercise;

    if (exercise == null) return;

    RoutineSetData setRoutine = await showAnimatedModal(
        context,
        SaveSetRoutineForm(
          exercise: exercise,
        ));

    BlocProvider.of<RoutineBloc>(context).add(SaveSet(setRoutine));
  }

  void saveRoutineHandler() async {
    await showAnimatedModal(context, SaveRoutineForm());
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
              onPressed: saveRoutineHandler,
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
            child: BlocBuilder<RoutinesBloc, RoutinesState>(
              builder: (context, state) {
                if (state is Routines) {
                  return ListView.separated(
                      itemBuilder: (context, i) => RoutineItem(
                            key: Key(i.toString()),
                            onTap: () {},
                          ),
                      separatorBuilder: (context, i) => SizedBox(
                            height: 15,
                          ),
                      itemCount: 6);
                }

                return Center(child: Text("No Routines here :("));
              },
            ),
          ),
        ),
      ),
    );
  }
}
