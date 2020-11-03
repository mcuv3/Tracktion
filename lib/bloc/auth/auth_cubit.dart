import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  Future<bool> login(String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(AuthSuccess(
        email: email, token: '1231234314', expiryDate: DateTime.now()));
    return true;
  }

  void checkCredentials() async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));
    //emit(AuthFailed());
    emit(AuthSuccess(
        email: 'asdfa', token: '1231234314', expiryDate: DateTime.now()));
  }
}
