import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/workout-picker/workoutpicker_bloc.dart';
import 'package:tracktion/widgets/items/WorkoutItem.dart';

class WorkoutPickedScreen extends StatefulWidget {
  final DateTime date;

  WorkoutPickedScreen(this.date);

  @override
  _WorkoutPickedScreenState createState() => _WorkoutPickedScreenState();
}

class _WorkoutPickedScreenState extends State<WorkoutPickedScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<WorkoutpickerBloc>(context).add(PickWorkout(widget.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<WorkoutpickerBloc, WorkoutpickerState>(
      builder: (context, state) {
        if (state is Workout) {
          final sets = state.sets;

          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: sets.length,
                        itemBuilder: (context, i) => WorkoutItem(
                              isSortMode: false,
                              delitionMode: false,
                              isSelected: false,
                              editable: false,
                              selectable: true,
                              onViewComment: (v) {},
                              set: sets[i],
                            )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 12,
                          ),
                          label: Text("Save")),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                        child: FlatButton.icon(
                            color: Colors.white,
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.edit,
                              size: 12,
                            ),
                            label: Text("Edit")),
                      ),
                      FlatButton.icon(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.levelUpAlt,
                            size: 12,
                          ),
                          label: Text("Cancel")),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
