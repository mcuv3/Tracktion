import 'package:flutter/material.dart';

class Divided extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final int spaceA;
  final int spaceB;
  const Divided(
      {Key key,
      this.leftWidget,
      this.rightWidget,
      this.spaceA = 2,
      this.spaceB = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: spaceA,
              child: Align(
                alignment: Alignment.center,
                child: leftWidget,
              ),
            ),
            VerticalDivider(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: spaceB,
              child: Align(
                alignment: Alignment.center,
                child: rightWidget,
              ),
            )
          ],
        ),
      ),
    );
  }
}
