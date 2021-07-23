import 'package:flutter/material.dart';

class AbstractShape extends StatelessWidget {
  final double width;
  final double height;
  final CustomPainter shape;
  AbstractShape(
      {required this.width, required this.height, required this.shape});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width,
          height), //You can Replace this with your desired WIDTH and HEIGHT
      painter: shape,
    );
  }
}

abstract class Shape extends CustomPainter {
  final Color color;
  Shape(this.color);
}
