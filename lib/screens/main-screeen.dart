import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import 'package:tracktion/global.dart';
import 'package:tracktion/screens/exercise/body-parts-screen.dart';
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/screens/routine/routine-main-screen.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/SvgImage.dart';

import '../colors/custom_colors.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/home";

  Widget makeFeatureBox(
      String text, Color bg, String route, BuildContext context, int n,
      [Color colorText = Colors.black]) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: SvgImage(
          "assets/poses/$n.svg",
          height: 200,
          width: 200,
          bgColor: Colors.white,
          text: Text(
            text,
            style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .routinesLight
                    .withOpacity(0.8),
                fontSize: 18),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final userName = TracktionGlobals.of(context).userPreferencesApp.nickname;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          if (state is AuthSuccess)
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(state.user.photoURL),
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
          else
            return FaIcon(FontAwesomeIcons.archway);
        }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: "CarterOne",
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    if (userName != null || userName != "")
                      TextSpan(
                          text: userName.toUpperCase().split(" ")[0],
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.routines)),
                    TextSpan(
                      text: " Let's start hitting those ",
                    ),
                    TextSpan(
                        text: "PR’s",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.routines)),
                  ]),
            ),
          ),
          Container(
            height: 400,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              children: [
                makeFeatureBox(
                  'Exercises',
                  Theme.of(context).colorScheme.exercise,
                  BodyPartsScreen.routeName,
                  context,
                  1,
                  Colors.white,
                ),
                makeFeatureBox(
                    'Routines',
                    Theme.of(context).colorScheme.routines,
                    RoutineMainScreen.routeName,
                    context,
                    5,
                    Colors.white),
                makeFeatureBox(
                    'Workouts',
                    Theme.of(context).colorScheme.workouts,
                    WorkOutScreen.routeName,
                    context,
                    3),
                makeFeatureBox(
                    'Analysis', // TODO: go to under development screen
                    Theme.of(context).colorScheme.analysis,
                    BodyPartsScreen.routeName,
                    context,
                    6)
              ],
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 12,
            ),
          ),
          SizedBox(height: AppBar().preferredSize.height)
        ],
      ),
    );
  }
}
