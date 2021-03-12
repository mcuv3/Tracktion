import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/set.dart';
import 'package:tracktion/widgets/items/reps-item.dart';

import '../../colors/custom_colors.dart';
import '../../util/mapWithIndex.dart';

class WorkoutItem extends StatelessWidget {
  final bool delitionMode;
  final bool isSortMode;
  final bool isSelected;
  final Function(Rep)? onViewComment;
  final bool editable;
  final bool selectable;
  final List<bool>? repsSelectors;
  final void Function({int? setId, int repIndex})? onCheckRep;
  final void Function(int? setId)? onCheckSet;
  final void Function(Rep rep, int repIndex)? onEditRep;
  final void Function(int? setId)? onDeleteSet;
  final bool touchable;

  final SetWorkout set;

  WorkoutItem(
      {this.delitionMode = false,
      this.isSelected = false,
      this.selectable = false,
      this.touchable = false,
      this.onCheckRep,
      this.onCheckSet,
      this.repsSelectors,
      this.onDeleteSet,
      this.onEditRep,
      required this.set,
      this.onViewComment,
      this.isSortMode = false,
      this.editable = false});

  @override
  Widget build(BuildContext context) {
    final header = Container(
      padding: EdgeInsets.only(left: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.exercise,
      ),
      child: Row(
        mainAxisAlignment: (selectable || editable)
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(
            set.exercise.name,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          if (selectable && onCheckSet != null)
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.analysis),
              child: Checkbox(
                checkColor: isSelected
                    ? Theme.of(context).colorScheme.analysis
                    : Colors.black,
                activeColor: Colors.white,
                visualDensity: VisualDensity.compact,
                value: isSelected,
                onChanged: (newValue) {
                  onCheckSet!(set.id);
                },
              ),
            ),
          if (editable && onDeleteSet != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () {
                onDeleteSet!(set.id);
              },
              color: Colors.white,
              padding: EdgeInsets.all(0),
            )
        ],
      ),
    );

    Widget buildAction(
        {required Rep rep,
        required bool selectedValue,
        required int index,
        required bool hasComment}) {
      if (selectable && onCheckRep != null) {
        return Checkbox(
          value: selectedValue,
          onChanged: (newValue) {
            onCheckRep!(setId: set.id, repIndex: index);
          },
        );
      } else if (editable && onEditRep != null) {
        return IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            Icons.edit,
          ),
          onPressed: () {
            onEditRep!(rep, index);
          },
          color: Colors.red,
          padding: EdgeInsets.all(0),
        );
      }
      return IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          hasComment ? Icons.comment : Icons.insert_comment_outlined,
        ),
        onPressed: onViewComment != null ? () => onViewComment!(rep) : null,
        color: Colors.red,
        padding: EdgeInsets.all(0),
      );
    }

    return ClipRRect(
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
                  color: isSelected ? Colors.red : Colors.transparent, width: 1)
              : null,
        ),
        // margin: EdgeInsets.only(bottom: 15),
        child: isSortMode
            ? Container(
                padding: EdgeInsets.all(4),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.exercise,
                ),
                child: Row(
                  mainAxisAlignment: selectable
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      set.exercise.name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  header,
                  ...set.reps
                      .mapIndex(
                        (rep, index) => RepItem(
                            selectable: selectable,
                            editable: editable,
                            reps: rep.reps,
                            weight: rep.weight,
                            rpe: rep.rpe,
                            actions: buildAction(
                                hasComment: rep.notes != "",
                                index: index,
                                rep: rep,
                                selectedValue: repsSelectors != null
                                    ? repsSelectors![index]
                                    : false)),
                      )
                      .toList(),
                ],
              ),
      ),
    );
  }
}
