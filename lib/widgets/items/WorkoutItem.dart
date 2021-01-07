import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/set.dart';
import 'package:tracktion/widgets/items/reps-item.dart';

import '../../colors/custom_colors.dart';

class WorkoutItem extends StatelessWidget {
  final bool delitionMode;
  final bool isSortMode;
  final bool isSelected;
  final Function(Rep) onViewComment;
  final bool editable;
  final bool selectable;
  final SetWorkout set;

  WorkoutItem(
      {this.delitionMode = false,
      this.isSelected = false,
      this.selectable = false,
      @required this.set,
      this.onViewComment,
      this.isSortMode = false,
      this.editable = false});
  @override
  Widget build(BuildContext context) {
    final header = Container(
      padding: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.exercise,
      ),
      child: Text(
        set.exercise.name,
        style: TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(delitionMode ? 0.5 : 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: delitionMode
                ? Border.all(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 1)
                : null,
          ),
          // margin: EdgeInsets.only(bottom: 15),
          child: isSortMode
              ? Row(
                  mainAxisAlignment: selectable
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.exercise,
                      ),
                      child: Text(
                        set.exercise.name,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (selectable)
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.white,
                        value: true,
                        onChanged: (newValue) {},
                      )
                  ],
                )
              : Column(
                  children: [
                    header,
                    for (final rep in set.reps)
                      RepItem(
                        selectable: selectable,
                        editable: editable,
                        hasComment: rep.notes != "",
                        reps: rep.reps,
                        weight: rep.weight,
                        rpe: rep.rpe,
                        onPressIcon: () => onViewComment(rep),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
