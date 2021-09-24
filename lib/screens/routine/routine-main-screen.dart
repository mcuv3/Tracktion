import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/bloc/routine-group/routine_bloc.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/forms/SaveGroupRoutine.dart';
import 'package:tracktion/widgets/items/GroupRoutineItem.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/CardInkwell.dart';

class RoutineMainScreen extends StatefulWidget {
  static const routeName = "/routine-main";

  @override
  _RoutineMainScreenState createState() => _RoutineMainScreenState();
}

class _RoutineMainScreenState extends State<RoutineMainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoutineGroupBloc>(context).add(StreamGroupRoutines());
  }

  void addRoutineGroupHanlder(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Scaffold(backgroundColor: Colors.white, body: SaveGroupRoutineForm()),
    );
  }

  void groupRoutineActions(RoutineGroupData group) async {
    final shouldDelete = await showAnimatedModal<bool>(
        context,
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: TextButton(
                    style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.exercise),
                    )),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.routines),
                    )),
              ),
            ],
          ),
        ));

    if (!(shouldDelete is bool)) return;

    if (shouldDelete)
      return BlocProvider.of<RoutineGroupBloc>(context)
          .add(DeleteGroupRoutine(group.id));

    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white, body: SaveGroupRoutineForm(group)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text("My Group Routines"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: BlocBuilder<RoutineGroupBloc, RoutineGroupState>(
              builder: (context, state) {
                if (state is RoutineGroups) {
                  final groups = state.groups;

                  return StreamBuilder(
                    builder: (context, res) => res.hasData
                        ? GridView.builder(
                            itemCount:
                                (res.data as List<RoutineGroupData>).length + 1,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, i) {
                              List<RoutineGroupData> groups = res.data;
                              if (i + 1 > groups.length) {
                                return AddGroupRoutine(addRoutineGroupHanlder);
                              }

                              return GroupRoutineItem(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RoutinesScreen.routeName,
                                      arguments: groups[i].id);
                                },
                                onLongPress: () =>
                                    groupRoutineActions(groups[i]),
                                index: i,
                                group: groups[i],
                              );
                            })
                        : AddGroupRoutine(() {}),
                    stream: groups,
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            )));
  }
}

class AddGroupRoutine extends StatelessWidget {
  final Function onPressed;

  AddGroupRoutine(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return CardInkwell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.plusCircle,
            color: Theme.of(context).colorScheme.routines,
            size: 36,
          ),
          Text("Add Group Routine",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.exercise)),
        ],
      ),
      onTap: () => onPressed(context),
    );
  }
}
