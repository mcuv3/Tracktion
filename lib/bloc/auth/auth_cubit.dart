import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    Response response;
    try {
      response = await http.post('http://10.0.2.2:8000/api/user/token/',
          body: {"email": email, "password": password});
    } catch (e) {
      print(e);
      return emit(AuthFailed());
    }

    if (response.statusCode == 401) return emit(AuthFailed());

    var data = json.decode(response.body);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['token']);

    emit(AuthSuccess(
        email: email, token: data['token'], expiryDate: DateTime.now()));
  }

  void checkCredentials() async {
//    if (state is AuthFailed) return emit(AuthFailed());

    emit(AuthLoading());

    var prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('token')) return emit(AuthFailed());

    Response response;
    try {
      var token = prefs.getString('token');

      print(token);
      response = await http.get(
        "http://10.0.2.2:8000/api/user/me/",
        headers: {"Authorization": "Token $token"},
      );
    } catch (e) {
      return emit(AuthFailed());
    }

    if (response.statusCode == 401) return emit(AuthFailed());

    var data = json.decode(response.body);

    emit(AuthSuccess(
        email: 'sdfas', token: data['token'], expiryDate: DateTime.now()));
  }

  Future<bool> register(String email, String name, String password) async {
    final res = await http.post('http://10.0.2.2:8000/api/user/create/',
        body: {"email": email, "password": password, "name": name});

    if (res.statusCode == 400) return false;

    return true;
  }

  logut() async {
    emit(AuthLoading());
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    emit(AuthFailed());
  }
}
