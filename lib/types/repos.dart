import 'package:tracktion/models/app/preferences.dart';

abstract class IPreferences {
  Future<PreferenceApp> savePreference(PreferenceApp report);
  Future<PreferenceApp> loadPreference();
}
