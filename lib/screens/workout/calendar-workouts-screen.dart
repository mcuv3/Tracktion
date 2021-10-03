import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import 'package:tracktion/colors/constants.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/db/database.dart' as db;
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/body-part.dart';

class CalendarWorkoutScreen extends StatefulWidget {
  final IconData actionIcon;
  final String actionLabel;
  final Function(DateTime) onWorkoutSelected;

  CalendarWorkoutScreen(
      {@required this.actionIcon,
      @required this.actionLabel,
      @required this.onWorkoutSelected});

  @override
  _CalendarWorkoutScreenState createState() => _CalendarWorkoutScreenState();
}

class _CalendarWorkoutScreenState extends State<CalendarWorkoutScreen> {
  ValueNotifier<List<BodyPartEnum>> _workoutBodyParts = ValueNotifier([]);
  ValueNotifier<List<db.Exercise>> _workoutExercises = ValueNotifier([]);
  ValueNotifier<Map<DateTime, Map<DateTime, WorkoutApp>>> _workouts =
      ValueNotifier(Map());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  var currentMonth = DateTime.now();

  var copyable = false;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    Future.delayed(Duration.zero).then((_) {
      final dates = _getMonthIntervals(DateTime.now());
      currentMonth = dates[0];
      BlocProvider.of<WorkoutpickerBloc>(context)
          .add(FetchWorkoutByDate(dates[0], dates[1]));
    });
  }

  @override
  void deactivate() {
    BlocProvider.of<WorkoutpickerBloc>(context).add(ResetWorkoutCalendar());
    super.deactivate();
  }

  @override
  void dispose() {
    if (_workoutBodyParts != null) {
      _workoutBodyParts.dispose();
    }
    super.dispose();
  }

  List<BodyPartEnum> _getEventsForDay(DateTime day) {
    final wk = getWorkoutForDate(day);
    if (wk == null) return [];
    return wk.metadata.bodyParts.toList();
  }

  WorkoutApp getWorkoutForDate(DateTime day) {
    final month = _workouts.value[currentMonth];
    if (month == null) return null;
    final wk = month[DateTime(day.year, day.month, day.day)];
    if (wk == null) return null;
    return wk;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final wk = getWorkoutForDate(selectedDay);
    _workoutBodyParts.value = wk != null ? wk.metadata.bodyParts.toList() : [];
    // if (!isSameDay(_selectedDay, selectedDay)) {
    // Navigator.of(context).pop(selectedDay);

    if (wk != null)
      BlocProvider.of<WorkoutpickerBloc>(context).add(
        FetchWorkoutExercises(wk.id),
      );
    else
      _workoutExercises.value = [];

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
    setState(() {
      currentMonth = dates[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<WorkoutpickerBloc, WorkoutpickerState>(
          listener: (context, state) {
            if (state is WorkoutCalendar) {
              _workouts.value = state.workoutsMonth;
              _workoutExercises.value = state.workoutExercise;
            }
          },
          child: Column(
            children: [
              ValueListenableBuilder<Map<DateTime, Map<DateTime, WorkoutApp>>>(
                valueListenable: _workouts,
                builder: (context, value, _) => TableCalendar<BodyPartEnum>(
                  firstDay: DateTime(1999, 6, 22),
                  lastDay: DateTime.now(),
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
              Divider(
                thickness: 1,
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: ValueListenableBuilder<List<db.Exercise>>(
                        valueListenable: _workoutExercises,
                        builder: (context, value, _) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                final exe = value[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      boxShadow: shadowList,
                                      color: Colors.white),
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    leading: FaIcon(FontAwesomeIcons.dumbbell,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .analysisLight),
                                    title: Text(exe.name,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    subtitle: Text(
                                        "Difficulty: ${enumToString(exe.difficulty)}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .analysis
                                                .withOpacity(0.7))),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ValueListenableBuilder<List<BodyPartEnum>>(
                        valueListenable: _workoutBodyParts,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return BodyPartWidget(
                                value[index],
                                active: true,
                                width: 50,
                                height: 80,
                                padding: EdgeInsets.all(2),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButton: copyable
          ? ElevatedButton.icon(
              onPressed: () => widget.onWorkoutSelected(_selectedDay),
              label: Text(widget.actionLabel),
              icon: Icon(widget.actionIcon),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.routines),
            )
          : null,
    );
  }
}
