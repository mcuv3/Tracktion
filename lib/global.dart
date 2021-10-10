import 'package:flutter/material.dart';
import "package:tracktion/models/app/index.dart";

class TracktionGlobals extends InheritedWidget {
  TracktionGlobals({Key key, this.child}) : super(key: key, child: child);

  final Widget child;
  final PreferenceApp userPreferencesApp = PreferenceApp(metric: Metric.kg);

  updatePreferences(PreferenceApp userPreferencesApp) {
    this.userPreferencesApp.age = userPreferencesApp.age;
    this.userPreferencesApp.defaultIncrement =
        userPreferencesApp.defaultIncrement;
    this.userPreferencesApp.metric = userPreferencesApp.metric;
    this.userPreferencesApp.name = userPreferencesApp.name;
    this.userPreferencesApp.nickname = userPreferencesApp.nickname;
    this.userPreferencesApp.weight = userPreferencesApp.weight;
  }

  String getWeightString(double val) {
    final value = this.getWeight(val);
    if (userPreferencesApp.metric == Metric.kg) {
      return "${value.toStringAsFixed(1)} kg";
    } else {
      return "${value.toStringAsFixed(1)} lbs";
    }
  }

  double getWeight(double val) {
    if (userPreferencesApp.metric == Metric.kg) {
      return val;
    } else {
      return val * 2.20462;
    }
  }

  double getKg(double val) {
    if (userPreferencesApp.metric == Metric.kg) {
      return val;
    } else {
      return val / 2.20462;
    }
  }

  static TracktionGlobals of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TracktionGlobals>();
  }

  @override
  bool updateShouldNotify(TracktionGlobals oldWidget) {
    return true;
  }
}
