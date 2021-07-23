import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/screens/index.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            arrowColor: Colors.black,
            accountEmail: Text("mcuve@outlook.com"),
            accountName: Text("Mauricio Antonio"),
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("Avatar"),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.home),
            title: Text("Home"),
            onTap: () {
              print("Home Clicked");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.running),
            title: Text("Exercises"),
            onTap: () {
              print("Categories Clicked");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BodyPartsScreen()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.dumbbell,
              size: 20,
            ),
            title: Text("Workouts"),
            onTap: () {
              print("Categories Clicked");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WorkOutScreen()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.userAlt),
            title: Text("Profile"),
            onTap: () {
              print("Categories Clicked");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WorkOutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
