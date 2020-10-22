import 'package:flutter/material.dart';
import 'package:tracktion/screens/exercise.dart';
import '../colors/custom_colors.dart';

class MainScreen extends StatelessWidget {
  Widget makeFeatureBox(
      String text, Color bg, String route, BuildContext context,
      [Color colorText = Colors.black]) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        height: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(23), color: bg),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: colorText, fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Text("Start hitting your PR’s",
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    Container(
                      height: 400,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        children: [
                          makeFeatureBox(
                              'Excercise',
                              Theme.of(context).colorScheme.exercise,
                              ExerciseScreen.routeName,
                              context,
                              Colors.white),
                          makeFeatureBox(
                              'Routines',
                              Theme.of(context).colorScheme.routines,
                              ExerciseScreen.routeName,
                              context,
                              Colors.white),
                          makeFeatureBox(
                            'Workouts',
                            Theme.of(context).colorScheme.workouts,
                            ExerciseScreen.routeName,
                            context,
                          ),
                          makeFeatureBox(
                              'Analysis',
                              Theme.of(context).colorScheme.analysis,
                              ExerciseScreen.routeName,
                              context)
                        ],
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
