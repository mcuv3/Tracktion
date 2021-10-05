enum Metric { Kg, Lbs }

class PreferenceApp {
  final Metric metric;
  final String nickname;
  final double weight;
  final double defaultIncrement;
  final int age;

  PreferenceApp(
      {this.defaultIncrement,
      this.age,
      this.metric,
      this.nickname,
      this.weight});
}
