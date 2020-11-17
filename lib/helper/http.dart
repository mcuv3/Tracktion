import 'package:http/http.dart' as http;
import 'dart:convert';

class Ht {
  static String _token;

  static Map<String, String> headers = {'Content-type': 'application/json'};

  static const host = 'http://10.0.2.2:8000';

  static set token(String token) {
    Ht.headers["Authorization"] = 'Token $token';
    token = token;
  }

  static conv(dynamic src) => json.decode(src);

  static Future<http.Response> get(String path) async =>
      await http.get(host + path, headers: headers);
  static Future<http.Response> patch(String path,
          {Map<String, dynamic> body}) =>
      http.patch(host + path, headers: headers, body: body);
  static Future<http.Response> put(String path, {Map<String, dynamic> body}) =>
      http.put(host + path, headers: headers, body: body);
  static Future<http.Response> delete(String path) =>
      http.delete(host + path, headers: headers);
  static Future<http.Response> post(String path, {dynamic body}) async {
    print(host + path);
    return await http
        .post(host + path, headers: headers, body: body)
        .catchError((e) => throw e);
  }
}
