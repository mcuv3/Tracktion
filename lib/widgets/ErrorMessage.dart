import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Color primaryColor;
  final Color secundaryColor;
  final String text;

  ErrorMessage(
      {required this.primaryColor,
      required this.secundaryColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error,
          color: primaryColor,
          size: 45,
        ),
        SizedBox(height: 10),
        Text(text, style: TextStyle(color: secundaryColor, fontSize: 22))
      ],
    );
  }
}
