import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:tracktion/colors/custom_colors.dart";

class UnderDevelopmentScreen extends StatelessWidget {
  static const routeName = "/under-development";

  const UnderDevelopmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.analysis,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.briefcase,
              size: 50,
              color: Theme.of(context).colorScheme.routines,
            ),
            Text(
              "Under Development, sorry",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.analysis, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
