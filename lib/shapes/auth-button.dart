import 'package:flutter/material.dart';
import './AbstractShape.dart';

class AuthShape extends Shape {
  final Color color;
  AuthShape(this.color) : super(color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 1.01,
        size.width * 0.50, size.height * 0.50);
    path.quadraticBezierTo(
        size.width * 0.90, size.height * 0.01, size.width, size.height * 0.50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.50);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 1.01,
        size.width * 0.50, size.height * 0.50);
    path.quadraticBezierTo(
        size.width * 0.90, size.height * 0.01, size.width, size.height * 0.50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.50);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
