import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import "package:tracktion/models/db/database.dart";
import 'package:tracktion/widgets/ui/CardInkwell.dart';

const vectorsPath = "assets/vectors/routines";

class GroupRoutineItem extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final RoutineGroupData group;
  final int index;
  GroupRoutineItem({this.onTap, this.index, this.onLongPress, this.group});

  @override
  Widget build(BuildContext context) {
    return CardInkwell(
      ClipRRect(
        child: Column(
          children: <Widget>[
            Text(group.name, style: TextStyle(color: Colors.black)),
            buildVector(),
          ],
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  Container buildVector() {
    var idx = index;
    if (index == 0 || index > 6) {
      Random rnd;
      int min = 1;
      int max = 6;
      rnd = new Random();
      idx = min + rnd.nextInt(max - min);
    }

    return Container(
      width: double.infinity,
      child: Center(
        child: SvgPicture.asset(
          'assets/vectors/routines/$idx.svg',
          height: 90,
          width: 200,
        ),
      ),
    );
  }
}
