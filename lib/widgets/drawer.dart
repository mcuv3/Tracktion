import 'package:flutter/material.dart';
import 'package:tracktion/screens/index.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      semanticLabel: "sd",
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("kalpesh.khandla@bosc.in"),
            accountName: Text("Kalpesh Khandla"),
            currentAccountPicture: CircleAvatar(
              child: Text("KK"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
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
            leading: Icon(Icons.dashboard),
            title: Text("Categories"),
            onTap: () {
              print("Categories Clicked");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BodyPartsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Workouts"),
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
