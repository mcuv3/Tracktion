import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import "package:tracktion/colors/custom_colors.dart";

class CalendarScreen extends StatelessWidget {
  final DateTime currentDate;
  final Map<DateTime, List<CleanCalendarEvent>> events;

  CalendarScreen({this.currentDate, this.events = const {}});

  @override
  Widget build(BuildContext context) {
    print(currentDate);
    return Material(
      child: SafeArea(
          top: false,
          child: Container(
            height: 350,
            child: Calendar(
              isExpanded: true,
              events: events,
              startOnMonday: true,
              weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
              onDateSelected: (date) {
                Navigator.of(context).pop(date);
              },
              hideTodayIcon: true,
              eventDoneColor: Colors.redAccent,
              selectedColor: Theme.of(context).colorScheme.exercise,
              todayColor: Theme.of(context).colorScheme.exercise,
              dayBuilder: (context, date) => date == currentDate
                  ? Center(
                      child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red.withOpacity(0.8)),
                      child: Text(date.day.toString(),
                          style: TextStyle(color: Colors.white)),
                    ))
                  : Center(child: Text(date.day.toString())),
              eventColor: Colors.redAccent,
              dayOfWeekStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 11),
            ),
          )),
    );
  }
}
