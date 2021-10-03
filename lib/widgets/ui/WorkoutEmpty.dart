import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/screens/workout/calendar-workouts-screen.dart';
import 'package:tracktion/screens/workout/workout-copy-screen.dart';
import 'package:tracktion/screens/workout/workout-routine-search-screen.dart';

class WorkoutEmpty extends StatelessWidget {
  final DateTime currentDate;
  const WorkoutEmpty({
    Key key,
    @required this.currentDate,
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
                  onPressed: () => showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => CalendarWorkoutScreen(
                          actionIcon: Icons.copy,
                          actionLabel: "Copy Workout",
                          onWorkoutSelected: (date) async {
                            final applied = await showCupertinoModalBottomSheet(
                              expand: true,
                              isDismissible: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => WorkoutPickedScreen(
                                targetDate: currentDate,
                                datePicked: date,
                              ),
                            );

                            if (applied is bool && !applied) {
                              BlocProvider.of<WorkoutpickerBloc>(context)
                                  .add(RestoreWorkoutCalendar());
                            }
                          },
                        ),
                      ),
                  icon: FaIcon(
                    FontAwesomeIcons.copy,
                    size: 25,
                    color: Colors.red,
                  ),
                  label: Text('Copy Workout')),
            ],
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(WorkoutRoutinePicker.routeName)
                    .then((routine) => routine != null
                        ? WorkOutScreenService.of(context)
                            .routineSelectedHanlder(routine, currentDate)
                        : null);
              },
              icon: FaIcon(
                FontAwesomeIcons.list,
                size: 25,
                color: Theme.of(context).colorScheme.analysis.withOpacity(0.7),
              ),
              label: Text('Start Routine',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.analysis)))
        ],
      )),
    );
  }
}
