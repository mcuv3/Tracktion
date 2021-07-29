import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/routine/routine_bloc.dart';
import 'package:tracktion/bloc/routines/routines_bloc.dart';
import 'package:tracktion/models/app/index.dart' as app;
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/screens/exercise/body-parts-screen.dart';
import 'package:tracktion/util/showModalConfirmation.dart';
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

  void saveSetRoutineHandler(BuildContext context, int routineId,
      [RoutineSetData set]) async {
    app.Exercise exercise;

    if (set == null) {
      exercise = await Navigator.of(context).pushNamed(
          BodyPartsScreen.routeName,
          arguments: {"readOnly": true}) as app.Exercise;

      if (exercise == null) return;
    }

    RoutineSetData setRoutine = await showAnimatedModal(
        context,
        SaveSetRoutineForm(
          exercise: exercise,
          routineId: routineId,
          set: set,
        ));

    if (setRoutine == null) return;

    BlocProvider.of<RoutineBloc>(context).add(SaveSet(setRoutine));
  }

  void deleteSetRoutine(BuildContext context, RoutineSetData set) async {
    final shouldDelete = await showModalConfirmation(
        context: context,
        contentText: "Are you sure you want to delete this set?");
    if (shouldDelete == null || !shouldDelete) return;
    BlocProvider.of<RoutineBloc>(context).add(DeleteSet(set));
  }

  void deleteRoutine(BuildContext context, int routineId) async {
    final shouldDelete = await showModalConfirmation(
        context: context,
        contentText: "Are you sure you want to delete this routine?");
    if (shouldDelete == null || !shouldDelete) return;
    BlocProvider.of<RoutinesBloc>(context).add(DeleteRoutine(routineId));
  }

  void saveRoutineHandler(BuildContext context, int groupId,
      [RoutineData routine]) async {
    RoutineData newRoutine = await showAnimatedModal(
        context,
        SaveRoutineForm(
          groupId: groupId,
          routine: routine,
        ));

    if (newRoutine == null) return;

    BlocProvider.of<RoutinesBloc>(context).add(SaveRoutine(newRoutine));
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
  int groupId;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      groupId = ModalRoute.of(context).settings.arguments as int;
      BlocProvider.of<RoutinesBloc>(context).add(StreamRoutines(groupId));
    });
  }

  void addRoutineHandler() async {
    RoutineData newRoutine = await showAnimatedModal(
        context,
        SaveRoutineForm(
          groupId: groupId,
        ));

    if (newRoutine == null) return;

    BlocProvider.of<RoutinesBloc>(context).add(SaveRoutine(newRoutine));
  }

  @override
  Widget build(BuildContext rootContext) {
    return RoutinesService(
      editMode: editMode,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Routines'),
          actions: [
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: FaIcon(FontAwesomeIcons.plusCircle),
              onPressed: addRoutineHandler,
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
                  return StreamBuilder(
                      stream: state.routines,
                      builder: (context, streamState) {
                        List<app.RoutineDay> routines = streamState.data ?? [];
                        if (routines.isEmpty ||
                            streamState.hasError ||
                            !streamState.hasData)
                          return Center(child: Text("No Routines here :("));
                        routines.sort(
                            (r1, r2) => r1.routine.id.compareTo(r2.routine.id));

                        return ListView.separated(
                            itemBuilder: (context, i) => RoutineItem(
                                  key: Key(i.toString()),
                                  onTap: () {},
                                  routineDay: routines[i],
                                ),
                            separatorBuilder: (context, i) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: routines.length);
                      });
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
