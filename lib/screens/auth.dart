import 'package:flutter/material.dart';
import 'package:tracktion/forms/auth-form.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/auth-button.dart';
import 'package:tracktion/shapes/head.dart';
import 'package:tracktion/vectors/home.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
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
            Stack(
              children: [
                AbstractShape(
                  height: query.size.height * 0.8,
                  width: double.infinity,
                  shape: AuthShape(Theme.of(context).primaryColorLight),
                ),
                AbstractShape(
                  height: query.size.height * 0.868,
                  width: double.infinity,
                  shape: AuthShape(Theme.of(context).primaryColor),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeVector(),
                    SizedBox(
                      height: 60,
                    ),
                    AuthForm(),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
