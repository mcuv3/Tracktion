import 'package:flutter/material.dart';
import './AbstractShape.dart';

class AuthShape extends Shape {
  final Color color;
  AuthShape(this.color) : super(color);
  @override
  void paint(Canvas canvas, Size size) {

  Paint paint_0 = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
     
        Path path_0 = Path();
    path_0.moveTo(0,size.height*0.30);
    path_0.quadraticBezierTo(size.width*0.21,size.height*0.39,size.width*0.51,size.height*0.30);
    path_0.quadraticBezierTo(size.width*0.77,size.height*0.22,size.width,size.height*0.33);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(0,size.height*0.30);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
     
         
    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.30);
    path_0.quadraticBezierTo(size.width*0.21,size.height*0.39,size.width*0.51,size.height*0.30);
    path_0.quadraticBezierTo(size.width*0.77,size.height*0.22,size.width,size.height*0.33);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(0,size.height*0.30);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

