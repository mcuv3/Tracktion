import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/screens/workout/calendar-picker-screen.dart';

class WorkoutEmpty extends StatelessWidget {
  final DateTime currentDate;
  const WorkoutEmpty({
    Key? key,
    required this.currentDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.dumbbell,
            size: 100,
            color: Colors.red,
          ),
          Text(
            "Start tracking your workout now!",
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(BodyPartsScreen.routeName,
                        arguments: {"pushed": true});
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 25,
                    color: Colors.red,
                  ),
                  label: Text('Add exercises')),
              TextButton.icon(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CalendarScreen(currentDate),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.copy,
                    size: 25,
                    color: Colors.red,
                  ),
                  label: Text('Copy Workout')),
            ],
          )
        ],
      )),
    );
  }
}
