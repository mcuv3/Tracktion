import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/auth/auth_cubit.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/screens/index.dart';
import 'package:tracktion/screens/routine/routine-main-screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      child: Drawer(
        elevation: 3,
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          var name = "";
          var email = "";
          var photoUrl = "";
          if (state is AuthSuccess) {
            name = state.user.displayName;
            photoUrl = state.user.photoURL;
            email = state.user.email;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // UserAccountsDrawerHeader(
              //   arrowColor: Colors.black,
              //   accountEmail: Text(email),
              //   accountName: Text(name),
              //   decoration: BoxDecoration(color: Colors.black),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundImage: NetworkImage(photoUrl),
              //     backgroundColor: Colors.transparent,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "  Tracktion",
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).colorScheme.routines),
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.home,
                    color: Theme.of(context).colorScheme.routinesLight),
                title: Text("Home"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.running,
                    color: Theme.of(context).colorScheme.routines),
                title: Text("Exercises"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BodyPartsScreen()),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.dumbbell,
                  color: Theme.of(context).colorScheme.routines,
                  size: 20,
                ),
                title: Text("Workouts"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WorkOutScreen()),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.thList,
                  color: Theme.of(context).colorScheme.routines,
                  size: 20,
                ),
                title: Text("Routines"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoutineMainScreen()),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cog,
                    color: Theme.of(context).colorScheme.routines),
                title: Text("Preferences"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfigurationUserScreen()),
                  );
                },
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.signOutAlt,
                      color: Theme.of(context).colorScheme.routines),
                  title: Text("LogOut"),
                  onTap: () => BlocProvider.of<AuthCubit>(context).logut()),
            ],
          );
        }),
      ),
    );
  }
}
