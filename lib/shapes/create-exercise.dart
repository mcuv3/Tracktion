

import 'package:flutter/material.dart';
import 'package:tracktion/shapes/AbstractShape.dart';

class CreateExerciseShape extends Shape{
    final Color color;
  CreateExerciseShape(this.color) : super(color);
  @override
  void paint(Canvas canvas, Size size) {
    

  Paint paint_0 = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.12,0);
    path_0.lineTo(size.width,0);
    path_0.lineTo(size.width,size.height*0.35);
    path_0.lineTo(size.width*0.24,size.height*0.21);
    path_0.lineTo(size.width*0.12,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
