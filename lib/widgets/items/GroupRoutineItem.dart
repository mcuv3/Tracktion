import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const vectorsPath = "assets/vectors/routines";

class GroupRoutineItem extends StatelessWidget {
  final Function onTap;
  final int index;
  GroupRoutineItem({this.onTap, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0),
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.red,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.2),
          splashFactory: InkSplash.splashFactory,
          child: ClipRRect(
            child: Column(
              children: <Widget>[
                Text('Push Pull Legs'),
                buildVector(),
              ],
            ),
          ),
        ),
      ),
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
