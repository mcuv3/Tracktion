part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;
  final DateTime expiryDate;
  final String token;
  AuthSuccess({this.email, this.expiryDate, this.token});
}

class AuthFailed extends AuthState {}
