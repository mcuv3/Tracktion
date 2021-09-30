import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import 'package:tracktion/models/app/workout-metadata.dart';

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
  ValueNotifier<List<String>> _selectedEvents = ValueNotifier([]);
  ValueNotifier<Map<DateTime, List<WorkoutApp>>> _workouts =
      ValueNotifier(Map());
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    Future.delayed(Duration.zero).then((_) {
      var now = new DateTime.now();

// Find the last day of the month.
      var start = (now.month < 12)
          ? DateTime(now.year, now.month + 1, 1)
          : DateTime(now.year + 1, 1, 1);
      var endDay = start.subtract(new Duration(days: 1)).day;
      var end = DateTime(now.year, now.month, endDay);
      BlocProvider.of<WorkoutpickerBloc>(context)
          .add(FetchWorkoutByDate(start, end));
    });
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
    _selectedEvents.value = ["1", "2", "3"];
    // if (!isSameDay(_selectedDay, selectedDay)) {
    // Navigator.of(context).pop(selectedDay);
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
      child: BlocListener<WorkoutpickerBloc, WorkoutpickerState>(
          listener: (context, state) {
            if (state is WorkoutCalendar) {
              print(state.workoutsMonth);
              _workouts.value = state.workoutsMonth;
            }
          },
          child: Column(
            children: [
              ValueListenableBuilder<Map<DateTime, List<WorkoutApp>>>(
                valueListenable: _workouts,
                builder: (context, value, _) => TableCalendar<String>(
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
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
