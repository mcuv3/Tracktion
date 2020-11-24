import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';

class RepItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("10 reps", style: textStyle),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Text("100 kg", style: textStyle),
            VerticalDivider(
              thickness: 2,
              color: Colors.red,
            ),
            Text("RPE 7", style: textStyle),
            Icon(Icons.comment, color: Colors.red)
          ],
        ),
      ),
    );
  }
}
