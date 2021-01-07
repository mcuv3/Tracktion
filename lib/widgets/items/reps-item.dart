import 'package:flutter/material.dart';

class RepItem extends StatelessWidget {
  final bool isExpanded;
  final int reps;
  final double weight;
  final int rpe;
  final bool hasComment;
  final Function onPressIcon;
  final bool editable;
  final bool selectable;

  RepItem(
      {@required this.hasComment,
      @required this.reps,
      @required this.weight,
      @required this.rpe,
      @required this.onPressIcon,
      this.selectable = false,
      this.isExpanded = false,
      this.editable = false});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget mainIcon = IconButton(
      visualDensity: VisualDensity.compact,
      icon: Icon(
        hasComment ? Icons.comment : Icons.insert_comment_outlined,
      ),
      onPressed: onPressIcon,
      color: Colors.red,
      padding: EdgeInsets.all(0),
    );

    if (editable)
      mainIcon = IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          Icons.edit,
        ),
        onPressed: onPressIcon,
        color: Colors.red,
        padding: EdgeInsets.all(0),
      );
    if (selectable) {
      mainIcon = Checkbox(
        value: false,
        onChanged: (newValue) {},
      );
    }

    return Container(
      height: 60,
      margin: isExpanded ? EdgeInsets.only(bottom: 10) : null,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isExpanded ? BorderRadius.circular(10) : null,
          border: isExpanded
              ? Border.all(color: Colors.black, width: 1)
              : Border.all(color: Colors.black, width: 0.1)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: deviceWidth * 0.2,
              child: FittedBox(
                fit: reps >= 100 ? BoxFit.contain : BoxFit.none,
                child: Text("$reps rep(s)", style: textStyle),
              ),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Container(
              width: deviceWidth * 0.2,
              child: FittedBox(
                fit: reps >= 999 ? BoxFit.contain : BoxFit.none,
                child: Text("$weight kg", style: textStyle),
              ),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Container(
              width: deviceWidth * 0.2,
              child: FittedBox(
                fit: BoxFit.none,
                child: Text("RPE $rpe", style: textStyle),
              ),
            ),
            mainIcon
          ],
        ),
      ),
    );
  }
}
