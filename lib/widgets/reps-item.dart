import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';

class RepItem extends StatelessWidget {
  final bool isExpanded;
  final int reps;
  final double weight;
  final int rpe;

  RepItem(
      {@required this.reps,
      @required this.weight,
      @required this.rpe,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);

    return Container(
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
            Text("$reps rep(s)", style: textStyle),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Text("$weight kg", style: textStyle),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Text("RPE $rpe", style: textStyle),
            Icon(Icons.comment, color: Colors.red)
          ],
        ),
      ),
    );
  }
}
