import 'package:flutter/material.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/auth-button.dart';
import 'package:tracktion/vectors/home.dart';
import 'package:tracktion/widgets/forms/auth-form.dart';

import '../../colors/custom_colors.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wellcome to TrackTion',
            style: TextStyle(fontSize: 24),
          ),
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: query.size.height < 550
                ? Theme.of(context).colorScheme.routines
                : Colors.transparent,
            child: Column(
              children: [
                query.size.height > 550
                    ? Stack(
                        // alignment: Alignment.center,
                        children: [
                          AbstractShape(
                            height: query.size.height * .9,
                            width: double.infinity,
                            shape:
                                AuthShape(Theme.of(context).primaryColorLight),
                          ),
                          Container(
                            child: AbstractShape(
                              height: query.size.height,
                              width: double.infinity,
                              shape: AuthShape(Theme.of(context).primaryColor),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeVector(),
                              SizedBox(height: 60),
                              AuthForm(),
                            ],
                          )
                        ],
                      )
                    : AuthForm(),
              ],
            ),
          ),
        ));
  }
}
