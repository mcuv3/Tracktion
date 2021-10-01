import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/workout-metadata.dart';
import 'package:tracktion/util/enumToString.dart';

final kToday = DateTime.now();
final now = DateTime.now();
final last = DateTime(now.year, now.month + 1, 0);
final start = DateTime(now.year, now.month, 1);
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
  ValueNotifier<List<BodyPartEnum>> _selectedEvents = ValueNotifier([]);
  ValueNotifier<Map<DateTime, Map<DateTime, WorkoutApp>>> _workouts =
      ValueNotifier(Map());
  CalendarFormat _calendarFormat = CalendarFormat.month;

  var copyable = false;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<WorkoutpickerBloc>(context)
          .add(FetchWorkoutByDate(start, last));
    });
  }

  @override
  void deactivate() {
    BlocProvider.of<WorkoutpickerBloc>(context).add(ResetWorkoutCalendar());
    super.deactivate();
  }

  @override
  void dispose() {
    if (_selectedEvents != null) {
      _selectedEvents.dispose();
    }
    super.dispose();
  }

  List<BodyPartEnum> _getEventsForDay(DateTime day) {
    final wk = getWorkoutForDate(day);
    if (wk == null) return [];
    return wk.metadata.bodyParts.toList();
  }

  WorkoutApp getWorkoutForDate(DateTime day) {
    final month = _workouts.value[start];
    if (month == null) return null;
    final wk = month[DateTime(day.year, day.month, day.day)];
    if (wk == null) return null;
    return wk;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final wk = getWorkoutForDate(selectedDay);
    _selectedEvents.value = wk != null ? wk.metadata.bodyParts.toList() : [];
    // if (!isSameDay(_selectedDay, selectedDay)) {
    // Navigator.of(context).pop(selectedDay);
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      copyable = wk != null;
    });

    // _selectedEvents.value = _getEventsForDay(selectedDay);
    // }
  }

  List<DateTime> _getMonthIntervals(DateTime date) => [
        DateTime(date.year, date.month, 1),
        DateTime(date.year, date.month + 1, 0)
      ];

  void onChangeMonth(DateTime date) {
    final dates = _getMonthIntervals(date);
    BlocProvider.of<WorkoutpickerBloc>(context)
        .add(FetchWorkoutByDate(dates[0], dates[1]));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentDate);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<WorkoutpickerBloc, WorkoutpickerState>(
          listener: (context, state) {
            if (state is WorkoutCalendar) {
              print(state.workoutsMonth);
              _workouts.value = state.workoutsMonth;
            }
          },
          child: Column(
            children: [
              ValueListenableBuilder<Map<DateTime, Map<DateTime, WorkoutApp>>>(
                valueListenable: _workouts,
                builder: (context, value, _) => TableCalendar<BodyPartEnum>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      // markerSize: 2.0,
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .exercise
                            .withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.exercise,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      markerDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.routines,
                        shape: BoxShape.circle,
                      )),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    if (focusedDay.day == 1) onChangeMonth(focusedDay);
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<BodyPartEnum>>(
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
                            title: Text(enumToString(value[index])),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: copyable
          ? ElevatedButton.icon(
              onPressed: () {},
              label: Text('Copy Workout'),
              icon: Icon(Icons.copy),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.routines),
            )
          : null,
    );
  }
}
