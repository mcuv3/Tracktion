part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserPreferences extends UserState {
  final PreferenceApp preferences;
  UserPreferences(this.preferences);
}

class UserPreferencesSuccess extends UserState {
  final String message;
  UserPreferencesSuccess(this.message);
}

class UserPreferencesError extends UserState {
  final String message;
  UserPreferencesError(this.message);
}
