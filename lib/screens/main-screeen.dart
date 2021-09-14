import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
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
                color: Theme.of(context).colorScheme.routinesLight,
                fontSize: 18),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                BlocProvider.of<AuthCubit>(context).logut();
              }),
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
                    Expanded(
                      child: Container(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          children: [
                            makeFeatureBox(
                              'Excercise',
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
                                'Analysis',
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
