import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/screens/workout/calendar-workouts-screen.dart';

import '../../colors/custom_colors.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {Key key, @required this.changeDate, @required this.currentDate})
      : super(key: key);

  final void Function(DateTime) changeDate;
  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border.all(width: 0.2, color: Colors.black),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 32,
                color: Theme.of(context).colorScheme.analysis,
              ),
              onPressed: () {
                changeDate(DateTime(
                    currentDate.year, currentDate.month, currentDate.day - 1));
              }),
          GestureDetector(
            onTap: () => showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => CalendarWorkoutScreen(
                  actionIcon: Icons.exit_to_app,
                  actionLabel: "Go to Workout",
                  onWorkoutSelected: (date) {
                    changeDate(date);
                    Navigator.of(context).pop();
                  }),
            ),
            child: Text(
                '${currentDate.day}-${currentDate.month}-${currentDate.year}',
                style: TextStyle(color: Colors.black)),
          ),
          IconButton(
              icon: Icon(
                Icons.chevron_right,
                size: 32,
                color: Theme.of(context).colorScheme.analysis,
              ),
              onPressed: () {
                changeDate(DateTime(
                    currentDate.year, currentDate.month, currentDate.day + 1));
              }),
        ],
      ),
    );
  }
}
