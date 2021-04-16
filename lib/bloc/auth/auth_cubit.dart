import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/http.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    Response response;
    try {
      final parserJson = json.encode({"email": email, "password": password});
      response = await Ht.post('/api/user/token/', body: parserJson);
    } catch (e) {
      print(e);
      return emit(AuthFailed());
    }

    if (response.statusCode == 401 || response.statusCode == 400) {
      return emit(AuthFailed());
    }

    var data = json.decode(response.body);

    final prefs = await SharedPreferences.getInstance();

    Ht.token = data['token'];

    await prefs.setString('token', data['token']);

    emit(AuthSuccess(
        email: email, token: data['token'], expiryDate: DateTime.now()));
  }

  void checkCredentials() async {
    emit(AuthLoading());
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return emit(AuthFailed());
    Response response;
    try {
      Ht.token = prefs.getString('token');
      response = await Ht.get("/api/user/me/");
    } catch (e) {
      print(e);
      return emit(AuthFailed());
    }
    if (response.statusCode == 401) return emit(AuthFailed());
    var data = json.decode(response.body);
    emit(AuthSuccess(
        email: 'sdfas', token: data['token'], expiryDate: DateTime.now()));
  }

  Future<bool> register(String email, String name, String password) async {
    Response res;

    emit(AuthLoading());
    try {
      final parserJson =
          json.encode({"email": email, "password": password, "name": name});
      res = await Ht.post('/api/user/create/', body: parserJson);
    } catch (e) {
      print(e);
      return true;
    }

    if (res.statusCode == 400) return false;

    emit(AuthFailed());
    return true;
  }

  logut() async {
    emit(AuthLoading());
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    emit(AuthFailed());
  }
}
