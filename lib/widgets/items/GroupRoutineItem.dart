import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracktion/widgets/ui/CardInkwell.dart';

const vectorsPath = "assets/vectors/routines";

class GroupRoutineItem extends StatelessWidget {
  final Function() onTap;
  final int index;
  GroupRoutineItem({required this.onTap, required this.index});

  @override
  Widget build(BuildContext context) {
    return CardInkwell(
      ClipRRect(
        child: Column(
          children: <Widget>[
            Text('Push Pull Legs'),
            buildVector(),
          ],
        ),
      ),
      onTap: onTap,
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
