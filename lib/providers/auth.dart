import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(
          DateTime.now(),
        )) {
      return _token;
    }
    return null;
  }

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
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticated(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticated(email, password, 'signInWithPassword');
  }
}
