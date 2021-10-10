import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/types/repos.dart';

class PreferencesRepository extends IPreferences {
  Future<PreferenceApp> savePreference(PreferenceApp preferences) {}

  Future<PreferenceApp> loadPreference() async {
    return PreferenceApp();
  }
}
