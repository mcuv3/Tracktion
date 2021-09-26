import 'package:flutter/material.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/inputs/Select.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/NumericSelector.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

enum Metrics { Kg, Lbs }

class ConfigurationUserScreen extends StatefulWidget {
  static const routeName = "/user/configuration";

  const ConfigurationUserScreen({Key key}) : super(key: key);

  @override
  _ConfigurationUserScreenState createState() =>
      _ConfigurationUserScreenState();
}

class _ConfigurationUserScreenState extends State<ConfigurationUserScreen> {
  var form = GlobalKey<FormState>();
  var formValues = {
    "nickname": "",
    "age": 0.0,
    "wight": 0.0,
    "metric": Metrics.Kg,
    "defaultIncrement": 2.5
  };

  Widget buildSection(String name, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.exercise,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  onChangeForm(String key, dynamic value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Preferences"),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection("User", context),
                SizedBox(
                  height: 10,
                ),
                Divided(
                    leftWidget:
                        Text("Nickname", style: TextStyle(fontSize: 18)),
                    rightWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TracktionInput(
                          change: (v) => onChangeForm("nickname", v),
                          hint: "mcuve",
                        ))),
                SizedBox(
                  height: 10,
                ),
                Divided(
                    leftWidget: Text("Weight", style: TextStyle(fontSize: 18)),
                    rightWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TracktionInput())),
                Divided(
                    leftWidget: Text("Age", style: TextStyle(fontSize: 18)),
                    rightWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TracktionInput())),
                SizedBox(
                  height: 10,
                ),
                buildSection("Application", context),
                SizedBox(
                  height: 10,
                ),
                Divided(
                    leftWidget: Text("Metric", style: TextStyle(fontSize: 18)),
                    rightWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Select<Metrics>(
                          options: Metrics.values,
                          onSelect: (v) {},
                          value: Metrics.Kg,
                        ))),
                SizedBox(
                  height: 10,
                ),
                Divided(
                    leftWidget:
                        Text("Default Inc", style: TextStyle(fontSize: 18)),
                    rightWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: NumericSelector(
                            value: "2.5kg", onPress: (direction) {}))),
                SizedBox(
                  height: 10,
                ),
                SaveFormActions(onCancel: () {}, onSave: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
