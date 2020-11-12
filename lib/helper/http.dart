import 'package:http/http.dart' as http;


class HttpHelper {
  String _token;

 

  set token(String token) {
    this._token = token;
  }

  get token {
    return this._token;
  }

  static sendRequest() {}
}
