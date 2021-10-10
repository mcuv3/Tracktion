import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/db/database.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SQLDatabase db;
  UserCubit(this.db) : super(UserInitial());

  Future<PreferenceApp> loadUserPreferences() async {
    emit(UserLoading());
    final preferences = await this.db.loadPreferences();
    emit(UserPreferences(preferences));
    return preferences;
  }

  saveUserPreferences(PreferenceApp preferences) async {
    final oldPreferences = (state as UserPreferences).preferences;
    emit(UserLoading());
    try {
      final newPreferences = oldPreferences.copyWith(
        age: preferences.age,
        defaultIncrement: preferences.defaultIncrement,
        metric: preferences.metric,
        weight: preferences.weight,
        name: preferences.name,
        nickname: preferences.nickname,
      );
      await this.db.savePreferences(newPreferences);
      emit(UserPreferencesSuccess("Saved successfully."));
      emit(UserPreferences(newPreferences));
    } catch (e) {
      print(e);
      emit(UserPreferencesError("Error saving preferences."));
      emit(UserPreferences(oldPreferences));
    }
  }
}
