import 'package:flutter/material.dart';
import 'package:tracktion/widgets/reps-item.dart';
import '../../colors/custom_colors.dart';
import 'package:tracktion/widgets/WorkOutSetItem.dart';
import 'package:tracktion/widgets/drawer.dart';

class WorkOutScreen extends StatelessWidget {
  static const routeName = "/workout";
  final exes = [
    {
      "name": "Deadlift",
      "series": [
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
      ]
    },
    {
      "name": "Deadlift",
      "series": [
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
      ]
    },
    {
      "name": "Deadlift",
      "series": [
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
      ]
    },
    {
      "name": "Deadlift",
      "series": [
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
        {"reps": 10, "weight": 100, "rpe": 7},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = [];
    exes.forEach((e) {
      items.add({"kind": "title", "value": e["name"]});
      items.add({"kind": "items", "value": e["series"]});
      items.add({"kind": "space"});
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: Icon(Icons.info), onPressed: () {}),
            IconButton(icon: Icon(Icons.timer), onPressed: () {}),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) {
                    if (items[i]["kind"] == "title") {
                      return Container(
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
                      );
                    }
                    if (items[i]["kind"] == "items") {
                      return RepItem();
                    }

                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: items.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
