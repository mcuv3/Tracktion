import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tracktion/screens/workout/workout-picker-screen.dart';

import '../../colors/custom_colors.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime currentDate;

  CalendarScreen(this.currentDate);

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _handleNewDate(date) {
    print(date);
    showCupertinoModalBottomSheet(
      expand: true,
      isDismissible: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkoutPickedScreen(
        targetDate: widget.currentDate,
        datePicked: date,
      ),
    );
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;

  final Map<DateTime, List> _events = {
    DateTime(2021, 1, 7): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2021, 1, 9): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2021, 1, 10): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2021, 1, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2021, 1, 25): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2021, 1, 6): [
      {'name': 'Event A', 'isDone': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
    Future.delayed(Duration.zero).then((_) {
      // final events = BlocProvider.of<Workout>(context).allWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Scaffold(
        body: Calendar(
          isExpanded: true,
          startOnMonday: true,
          weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
          events: _events,
          onDateSelected: (date) => _handleNewDate(date),
          hideTodayIcon: true,
          eventDoneColor: Colors.redAccent,
          selectedColor: Theme.of(context).colorScheme.exercise,
          todayColor: Theme.of(context).colorScheme.exercise,
          dayBuilder: (context, date) =>
              Center(child: Text(date.day.toString())),
          eventColor: Colors.redAccent,
          dayOfWeekStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
    );
  }
}
