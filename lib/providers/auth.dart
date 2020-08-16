import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _expityDate;
  String _userId;

  Future<void> _authenticated(
      String email, String password, String type) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$type?key=AIzaSyDXeUMKAcgAOmD86l5NwN8ux--lADfOwE8';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticated(email, password, 'signupNewUser');
  }

  Future<void> signin(String email, String password) async {
    return _authenticated(email, password, 'signInWithPassword');
  }
}
