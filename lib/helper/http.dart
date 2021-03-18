import 'dart:convert';

import 'package:http/http.dart' as http;

class Ht {
  static Map<String, String> headers = {'Content-type': 'application/json'};
  static final host = 'http://192.168.1.20:8000';

  static final verbs = {
    'post': (String path, dynamic body) =>
         http.post(Uri(path:host + path), headers: headers, body: body),
    'patch': (String path, dynamic body) =>
        http.patch(Uri(path:host + path), headers: headers, body: body),
    'delete': (String path, dynamic body) => http.delete(
          Uri(path:host + path),
          headers: headers,
        ),
    'get': (String path, dynamic body) => http.get(
          Uri(path:host + path),
          headers: headers,
        ),
    'put': (String path, dynamic body) =>
        http.put(Uri(path:host + path), headers: headers, body: body),
  };
  static set token(String? token) {
    Ht.headers["Authorization"] = 'Token $token';
    token = token;
  }

  static Future<http.Response> request(
      {required String path, required String verb, String payload = ""}) {
    final method = Ht.verbs[verb];
    if (method == null) return Future.error({"message": "Invalid verb"});
    return method(path, payload);
  }

  static conv(dynamic src) => json.decode(src);

    static Future<http.Response> get(String path) async =>
      await http.get(Uri(path:host + path), headers: headers);

  static Future<http.Response> put(String path, {dynamic body}) =>
      http.put(Uri(path:host + path), headers: headers, body: body);
  static Future<http.Response> delete(String path) =>
      http.delete(Uri(path:host + path), headers: headers);
  static Future<http.Response> post(String path, {dynamic body}) async {
    print(Uri(path:host + path));
    return await http
        .post(Uri(path:host + path), headers: headers, body: body)
        .catchError((e) => throw e);
  }
}
