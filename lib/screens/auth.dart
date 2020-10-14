import 'package:flutter/material.dart';
import 'package:tracktion/forms/auth-form.dart';
import 'package:tracktion/shapes/head.dart';
import 'package:tracktion/vectors/home.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wellcome to TrackTion',
            style: TextStyle(fontSize: 27),
          ),
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Column(
          children: [
            HomeVector(),
            Expanded(
              child: SignUp(),
            ),
          ],
        ));
  }
}
