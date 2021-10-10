import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/user/user_cubit.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/global.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/inputs/Select.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/NumericSelector.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class ConfigurationUserScreen extends StatefulWidget {
  static const routeName = "/user/configuration";

  const ConfigurationUserScreen({Key key}) : super(key: key);

  @override
  _ConfigurationUserScreenState createState() =>
      _ConfigurationUserScreenState();
}

class _ConfigurationUserScreenState extends State<ConfigurationUserScreen> {
  var form = GlobalKey<FormState>();
  var preferences = PreferenceApp();
  var formValues = {
    "nickname": "",
    "age": "0.0",
    "weight": "0.0",
    "metric": Metric.kg,
    "defaultIncrement": "2.5"
  };
  var fetched = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<UserCubit>(this.context).loadUserPreferences();
    });
    super.initState();
  }

  void submitForm() {
    if (!form.currentState.validate()) return;

    preferences = PreferenceApp(
      age: int.parse(formValues["age"]),
      defaultIncrement: double.parse(formValues["defaultIncrement"]),
      metric: formValues["metric"],
      nickname: formValues["nickname"],
      weight: double.parse(formValues["weight"]),
    );

    BlocProvider.of<UserCubit>(this.context).saveUserPreferences(preferences);
  }

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

  onChangeForm(String key, dynamic value) {
    setState(() {
      print(key);
      print(value);
      formValues[key] = value;
    });
  }

  String isValidPositiveNumber(String value) {
    final v = double.tryParse(value);
    if (v == null) return "Must be a number.";
    if (v <= 0) return "Must be positive number.";
    return null;
  }

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
            child:
                BlocConsumer<UserCubit, UserState>(listener: (context, state) {
              if (state is UserPreferencesSuccess) {
                TracktionGlobals.of(context).updatePreferences(preferences);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green.shade400,
                ));
              }
              if (state is UserPreferencesError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade400,
                ));
              }
            }, builder: (context, state) {
              if (state is UserLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is UserPreferences && !fetched) {
                fetched = true;
                formValues = {
                  "nickname": state.preferences.nickname,
                  "age": state.preferences.age.toString(),
                  "weight": state.preferences.weight.toString(),
                  "metric": state.preferences.metric,
                  "defaultIncrement":
                      state.preferences.defaultIncrement.toString()
                };
              }

              return Column(
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
                            validator: (v) => v.replaceAll(" ", "").isEmpty
                                ? "Required"
                                : null,
                            initialValue: formValues["nickname"],
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Divided(
                      leftWidget:
                          Text("Weight", style: TextStyle(fontSize: 18)),
                      rightWidget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TracktionInput(
                            keyboardType: TextInputType.number,
                            validator: isValidPositiveNumber,
                            change: (v) => onChangeForm("weight", v),
                            hint: "weight",
                            initialValue: formValues["weight"],
                          ))),
                  Divided(
                      leftWidget: Text("Age", style: TextStyle(fontSize: 18)),
                      rightWidget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TracktionInput(
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              final val = int.tryParse(v);
                              if (val == null || val <= 0)
                                return "Invalid age.";
                              return null;
                            },
                            change: (v) => onChangeForm("age", v),
                            hint: "age",
                            initialValue: formValues["age"].toString(),
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  buildSection("Application", context),
                  SizedBox(
                    height: 10,
                  ),
                  Divided(
                      leftWidget:
                          Text("Metric", style: TextStyle(fontSize: 18)),
                      rightWidget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Select<Metric>(
                            options: Metric.values,
                            onSelect: (v) {
                              onChangeForm("metric", v);
                            },
                            value: formValues["metric"],
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
                              value: formValues["defaultIncrement"],
                              onPress: (direction) {
                                final val = double.tryParse(
                                    formValues["defaultIncrement"]);
                                if (val == null ||
                                    (val <= 0.5 && direction == Direction.left))
                                  return;
                                final newVal = val +
                                    (direction == Direction.left ? -0.5 : 0.5);
                                setState(() {
                                  formValues["defaultIncrement"] =
                                      newVal.toString();
                                });
                              }))),
                  SizedBox(
                    height: 10,
                  ),
                  SaveFormActions(
                      onCancel: () {
                        Navigator.of(context).pushNamed("/home");
                      },
                      onSave: submitForm)
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
