import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/db/database.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SQLDatabase db;
  UserCubit(this.db) : super(UserInitial());

  loadUserPreferences() async {
    final preferences = await this.db.loadPreferences();
    emit(UserPreferences(preferences));
  }

  saveUserPreferences(PreferenceApp preferences) async {
    await this.db.savePreferences(preferences);
  }
}
