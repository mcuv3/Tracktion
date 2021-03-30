import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/screens/routine/routines-screen.dart';
import 'package:tracktion/widgets/ui/IconDetail.dart';

//TODO: needs implementation on querys as well the whole CRUD
class RoutineItem extends StatefulWidget {
  final Function onTap;
  final Key key;
  RoutineItem({@required this.key, @required this.onTap});

  @override
  _RoutineItemState createState() => _RoutineItemState();
}

class _RoutineItemState extends State<RoutineItem>
    with TickerProviderStateMixin {
  var isExpanded = false;

  List<RoutineSet> sets = [
    RoutineSet(),
    RoutineSet(),
    RoutineSet(),
    RoutineSet(),
    RoutineSet(),
    RoutineSet(),
    RoutineSet(),
  ];

  void expand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ),
          RoutineDetails(),
          if (isExpanded)
            Divider(
              thickness: 1,
              height: 1,
            ),
          AnimatedSize(
              key: widget.key,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
              vsync: this,
              child: Container(
                height: isExpanded ? ((sets.length) * 70.0) : null,
                width: double.infinity,
                child: Column(
                  children: [
                    if (isExpanded)
                      Expanded(
                          child: SetsRoutineItem(
                        sets: sets,
                      )),
                    Material(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1,
                              height: 1,
                            ),
                            InkWell(
                              onTap: expand,
                              highlightColor: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  isExpanded
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
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
  final List<RoutineSet> sets;

  const SetsRoutineItem({
    this.sets,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editMode = RoutinesService.of(context).editMode;
    return sets.length == 0
        ? Center(child: Text("No sets added"))
        : ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: ListTile.divideTiles(
                color: Colors.red,
                context: context,
                tiles: sets.map((e) => ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: FaIcon(FontAwesomeIcons.dumbbell,
                        color: Theme.of(context).colorScheme.analysisLight),
                    title: Text("Deadlift"),
                    subtitle: Text("Type: Smart - RPE:8"),
                    trailing: AnimatedOpacity(
                      opacity: editMode ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 400),
                      child: Container(
                        width: 50,
                        child: Row(
                          children: [
                            IconButton(
                                icon: FaIcon(FontAwesomeIcons.times,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .routinesLight),
                                onPressed: editMode ? () {} : null)
                          ],
                        ),
                      ),
                    )))).toList());
  }
}

class SetRoutineItem extends StatelessWidget {
  const SetRoutineItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Set 1");
  }
}

class RoutineDetails extends StatelessWidget {
  const RoutineDetails({
    Key key,
  }) : super(key: key);

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
            lead: "23",
            secondary: "set",
          ),
          IconDetail(
            icon: FaIcon(
              FontAwesomeIcons.running,
              size: 16,
            ),
            lead: "5",
            secondary: "exercise",
          ),
          IconDetail(
            icon: FaIcon(
              FontAwesomeIcons.hourglassHalf,
              size: 14,
            ),
            lead: "60",
            secondary: "min",
          ),
        ],
      ),
    );
  }
}

class RoutineHeader extends StatelessWidget {
  final Function() onNotes;

  const RoutineHeader({Key key, this.onNotes}) : super(key: key);

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
            "Push Day #1",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
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
                      onPressed: editMode ? () {} : null),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(
                        FontAwesomeIcons.edit,
                        color: Colors.white,
                      ),
                      onPressed: editMode ? () {} : null),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(FontAwesomeIcons.commentDots,
                          color: Colors.white),
                      onPressed: editMode ? () {} : null),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(FontAwesomeIcons.plusCircle,
                          color: Colors.white),
                      onPressed: editMode ? () {} : null),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
