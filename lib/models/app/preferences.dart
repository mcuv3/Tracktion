import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/util/enumToString.dart';

enum Metric { kg, lbs }

class PreferenceApp {
  Metric metric = Metric.kg;
  String nickname = "";
  String name = "";
  double weight = 0.0;
  double defaultIncrement = 2.5;
  int age = 0;
  Map<String, Preference> _preferences = {};

  PreferenceApp(
      {this.defaultIncrement,
      this.age,
      this.metric,
      this.name,
      this.nickname,
      this.weight});

  addPreference(String key, Preference pref) {
    _preferences[key] = pref;
  }

  Map<String, String> _toMap() => {
        "metric": enumToString(metric),
        "nickname": nickname,
        "name": name,
        "weight": weight.toString(),
        "defaultIncrement": defaultIncrement.toString(),
        "age": age.toString(),
      };

  List<Preference> get preferences {
    final values = _toMap();
    final List<Preference> ps = [];
    _preferences.forEach(((key, value) {
      ps.add(Preference(id: value.id, key: value.key, value: values[key]));
    }));
    return ps;
  }

  PreferenceApp copyWith(
          {Metric metric,
          String nickname,
          String name,
          double weight,
          double defaultIncrement,
          int age}) =>
      PreferenceApp(
        metric: metric ?? this.metric,
        nickname: nickname ?? this.nickname,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        defaultIncrement: defaultIncrement ?? this.defaultIncrement,
        age: age ?? this.age,
      );
}
