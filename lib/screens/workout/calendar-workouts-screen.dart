import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarWorkoutScreen extends StatefulWidget {
  final DateTime currentDate;
  final Map<DateTime, List<String>> events;

  CalendarWorkoutScreen({this.currentDate, this.events = const {}});

  @override
  _CalendarWorkoutScreenState createState() => _CalendarWorkoutScreenState();
}

class _CalendarWorkoutScreenState extends State<CalendarWorkoutScreen> {
  ValueNotifier<List<String>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    if (_selectedEvents != null) {
      _selectedEvents.dispose();
    }
    super.dispose();
  }

  List<String> _getEventsForDay(DateTime day) {
    // FIXME:  this triggers on days that have exercises.
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // if (!isSameDay(_selectedDay, selectedDay)) {
    Navigator.of(context).pop(selectedDay);
    // setState(() {
    //   _selectedDay = selectedDay;
    //   _focusedDay = focusedDay;
    // });

    // _selectedEvents.value = _getEventsForDay(selectedDay);
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentDate);
    return Material(
      color: Colors.white,
      child: TableCalendar<String>(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
        ),
        onDaySelected: _onDaySelected,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
