import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/auth-button.dart';
import 'package:tracktion/widgets/forms/AuthForm.dart';

// TODO: refactor all the login page to be more frendly with OAuth implmentation

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.analysis,
          child: Stack(
            children: [
              AbstractShape(
                height: query.size.height,
                width: double.infinity,
                shape: AuthShape(Colors.white),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 60),
                    // HomeVector(),

                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tracktion",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.routines,
                                fontSize: 34),
                          ),
                          Text(
                              "An app where you can track freely your workouts to ensure  progress in your journy.",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 150),
                    SingleChildScrollView(child: AuthForm())
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
