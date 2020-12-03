import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';
import 'package:tracktion/widgets/reps-item.dart';

class WorkOutSetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        15,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.routines,
              ),
              child: Text(
                "DeadLift",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                // shrinkWrap: true,
                // physics: ClampingScrollPhysics(),
                // itemBuilder: (ctx, i) {
                //   if (items[i]["kind"] == "title") {

                //   }
                //   if (items[i]["kind"] == "items") {}

                //   return SizedBox(height: 10,);
                // },
                // itemCount: items.length,
                )
          ],
        ),
      ),
    );
  }
}
