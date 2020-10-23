import 'package:flutter/material.dart';
import 'package:tracktion/shapes/AbstractShape.dart';

class ExerciseSearchShape extends Shape {
  final Color color;

  ExerciseSearchShape(this.color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * -0.09, size.height * 0.78,
        size.width * 0.02, size.height * 0.66);
    path.cubicTo(size.width * 0.27, size.height * 0.58, size.width * 0.63,
        size.height * 0.65, size.width, size.height * 0.31);
    path.quadraticBezierTo(
        size.width, size.height * 0.48, size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
