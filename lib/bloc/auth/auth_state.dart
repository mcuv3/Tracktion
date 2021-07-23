part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  final String email;
  final DateTime expiryDate;
  final String token;
  AuthInitial(
      {required this.email, required this.expiryDate, required this.token});
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;
  final DateTime expiryDate;
  final String token;
  AuthSuccess(
      {required this.email, required this.expiryDate, required this.token});
}

class AuthFailed extends AuthState {}
