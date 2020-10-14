import 'dart:ui';

import 'package:flutter/material.dart';

class ShapeHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      width: double.infinity,
      child: CustomPaint(
        size: Size(double.infinity, 150),
        painter: RPSCustomPainter(),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.00, size.height * 0.07);
    path.lineTo(size.width, size.height * 0.07);
    path.quadraticBezierTo(size.width * 1.00, size.height * 0.57,
        size.width * 0.50, size.height * 0.57);
    path.quadraticBezierTo(size.width * 0.00, size.height * 0.57,
        size.width * 0.00, size.height * 0.07);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
