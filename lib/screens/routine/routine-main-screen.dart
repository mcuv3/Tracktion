import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/screens/routine/save-group-screen.dart';
import 'package:tracktion/widgets/items/GroupRoutineItem.dart';
import 'package:tracktion/widgets/ui/CardInkwell.dart';

class RoutineMainScreen extends StatelessWidget {
  static const routeName = "/routine-main";

  void addRoutineGroupHanlder(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SaveRoutineGroupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Group Routines"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: 6 + 1,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, i) => i + 1 > 6
                    ? AddGroupRoutine(addRoutineGroupHanlder)
                    : GroupRoutineItem(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RoutinesScreen.routeName);
                        },
                        index: i,
                      ))));
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
