import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/auth-button.dart';
import 'package:tracktion/widgets/forms/AuthForm.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
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
                              "Start tracking your workouts, ensure you're making progress and be the best version of yourself.",
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
