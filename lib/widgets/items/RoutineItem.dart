import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/items/TracktionHeader.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/IconDetail.dart';

class RoutineItem extends StatefulWidget {
  final Function onTap;
  final Key key;
  final RoutineDay routineDay;
  RoutineItem(
      {@required this.key, @required this.onTap, @required this.routineDay});

  @override
  _RoutineItemState createState() => _RoutineItemState();
}

class _RoutineItemState extends State<RoutineItem>
    with TickerProviderStateMixin {
  var isExpanded = false;

  void expand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sets = widget.routineDay.sets;
    final editMode = RoutinesService.of(context).editMode;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          RoutineHeader(
            onNotes: () => expand(),
            routine: widget.routineDay.routine,
          ),
          RoutineDetails(
            duration: widget.routineDay.routine.duration,
            exercises: widget.routineDay.numExercises,
            series: widget.routineDay.numSeries,
          ),
          if (isExpanded)
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          AnimatedSize(
              key: widget.key,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
              vsync: this,
              child: Container(
                height: isExpanded
                    ? sets.length == 0
                        ? 100
                        : ((sets.length) * 70.0 + 15)
                    : null,
                width: double.infinity,
                child: Column(
                  children: [
                    if (isExpanded)
                      Expanded(
                          child: sets.length == 0
                              ? Container(
                                  height: 100,
                                  child: Center(child: Text("No sets added")))
                              : SetsRoutineItem(
                                  editMode: editMode,
                                  sets: widget.routineDay.sets,
                                  routineId: widget.routineDay.routine.id,
                                  onTapSet: (set) {
                                    RoutinesService.of(context)
                                        .saveSetRoutineHandler(context,
                                            widget.routineDay.routine.id, set);
                                  },
                                  onDeleteSet: (set) {
                                    RoutinesService.of(context)
                                        .deleteSetRoutine(context, set);
                                  },
                                )),
                    Material(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1,
                              height: 1,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            InkWell(
                              onTap: expand,
                              highlightColor: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  isExpanded
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class SetsRoutineItem extends StatelessWidget {
  final List<RoutineSetData> sets;
  final int routineId;
  final Function(RoutineSetData) onDeleteSet;
  final Function(RoutineSetData) onTapSet;
  final bool editMode;
  const SetsRoutineItem(
      {this.sets,
      Key key,
      @required this.routineId,
      this.editMode = false,
      @required this.onDeleteSet,
      this.onTapSet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: ListTile.divideTiles(
            color: Colors.red,
            context: context,
            tiles: sets.map((set) => SetRoutineItem(
                set: set,
                onTapSet: onTapSet,
                actionIcon: FontAwesomeIcons.times,
                editMode: editMode,
                onDeleteSet: onDeleteSet))).toList());
  }
}

class SetRoutineItem extends StatelessWidget {
  const SetRoutineItem(
      {Key key,
      @required this.onTapSet,
      @required this.editMode,
      @required this.onDeleteSet,
      @required this.actionIcon,
      @required this.set})
      : super(key: key);

  final IconData actionIcon;
  final RoutineSetData set;
  final Function(RoutineSetData p1) onTapSet;
  final bool editMode;
  final Function(RoutineSetData p1) onDeleteSet;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onTapSet(set),
        visualDensity: VisualDensity.compact,
        leading: FaIcon(FontAwesomeIcons.dumbbell,
            color: Theme.of(context).colorScheme.analysisLight),
        title: Text(set.exerciseName.toString(),
            style: const TextStyle(color: Colors.black)),
        subtitle: Text(
            "Type: ${enumToString(set.copyMethod)} - RPE:${set.targetRpe.toString()}",
            style: TextStyle(
                color:
                    Theme.of(context).colorScheme.analysis.withOpacity(0.7))),
        trailing: AnimatedOpacity(
          opacity: editMode ? 1.0 : 0.0,
          duration: Duration(milliseconds: 400),
          child: Container(
            width: 50,
            child: Row(
              children: [
                IconButton(
                    icon: FaIcon(actionIcon,
                        color: Theme.of(context).colorScheme.routinesLight),
                    onPressed: editMode ? () => onDeleteSet(set) : null)
              ],
            ),
          ),
        ));
  }
}

class RoutineDetails extends StatelessWidget {
  final int series;
  final int exercises;
  final int duration;

  const RoutineDetails(
      {Key key,
      @required this.series,
      @required this.exercises,
      @required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconDetail(
            icon: FaIcon(
              FontAwesomeIcons.dumbbell,
              size: 14,
            ),
            lead: series.toString(),
            secondary: "series",
          ),
          IconDetail(
            icon: FaIcon(
              FontAwesomeIcons.running,
              size: 16,
            ),
            lead: exercises.toString(),
            secondary: "exercise",
          ),
          IconDetail(
            icon: FaIcon(
              FontAwesomeIcons.hourglassHalf,
              size: 14,
            ),
            lead: duration.toString(),
            secondary: "min",
          ),
        ],
      ),
    );
  }
}

class RoutineHeader extends StatelessWidget {
  final Function() onNotes;

  final RoutineData routine;

  const RoutineHeader({Key key, @required this.onNotes, @required this.routine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editMode = RoutinesService.of(context).editMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Theme.of(context).colorScheme.analysis,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            routine.name,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Row(
            children: [
              AnimatedOpacity(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                opacity: editMode ? 1.0 : 0.0,
                child: Container(
                  height: 45,
                  child: Row(
                    children: [
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: FaIcon(
                            FontAwesomeIcons.trash,
                            color: Colors.white,
                          ),
                          onPressed: editMode
                              ? () {
                                  RoutinesService.of(context)
                                      .deleteRoutine(context, routine.id);
                                }
                              : null),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: FaIcon(
                            FontAwesomeIcons.edit,
                            color: Colors.white,
                          ),
                          onPressed: editMode
                              ? () {
                                  RoutinesService.of(context)
                                      .saveRoutineHandler(
                                          context, routine.groupId, routine);
                                }
                              : null),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: FaIcon(FontAwesomeIcons.plusCircle,
                              color: Colors.white),
                          onPressed: editMode
                              ? () {
                                  RoutinesService.of(context)
                                      .saveSetRoutineHandler(
                                          context, routine.id);
                                }
                              : null),
                    ],
                  ),
                ),
              ),
              if (!editMode)
                AnimatedOpacity(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 400),
                  opacity: editMode ? 0.0 : 1.0,
                  child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(FontAwesomeIcons.infoCircle,
                          color: Colors.white),
                      onPressed: () => showAnimatedModal(
                          context,
                          TracktionNotifyModal(
                              description: routine.notes,
                              title: "Notes",
                              type: NotifyType.Info))),
                )
            ],
          ),
        ],
      ),
    );
  }
}
