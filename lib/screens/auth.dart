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
            HomeVector(),
            Expanded(
              child: Stack(
                children: [
                  AbstractShape(
                    height: 100,
                    width: double.infinity,
                    shape: AuthShape(Theme.of(context).primaryColorLight),
                  ),
                  AbstractShape(
                    height: 120,
                    width: double.infinity,
                    shape: AuthShape(Theme.of(context).primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: AuthForm(),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: SignUp(),
            // ),
          ],
        ));
  }
}
