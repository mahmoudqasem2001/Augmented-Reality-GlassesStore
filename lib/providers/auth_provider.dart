import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  Timer? _auhtTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return '';
  }

  Future<void> _authenticateRegistration(
    String email,
    String password,
    String? userType,
    String urlSegment,
  ) async {
    final url =
        'https://ar-store-production.up.railway.app/api/auth/${urlSegment}';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'userType': userType,
          }));
      final responseDate = json.decode(res.body);
      _token = responseDate['token'];

      // _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        // 'userId': _userId,
        // 'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _authenticateLogin(
      String email, String password, String urlSegment) async {
    final url =
        'https://ar-store-production.up.railway.app/api/auth/${urlSegment}';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
          }));
      final responseDate = json.decode(res.body);
      if (responseDate['error'] != null) {
        throw HttpException(responseDate['error']['message']);
      }
      _token = responseDate['token'];
      // _userId = responseDate['localId'];
      // _expiryDate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responseDate['expiresIn'])));

      // _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        // 'userId': _userId,
        // 'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String userType) async {
    return _authenticateRegistration(email, password, userType, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticateLogin(email, password, "login");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;

    final Map<String, Object> extractedData = json
        .decode(prefs.getString('userData') as String) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedData['token'] as String;
    // _userId = extractedData['userId'] as String;
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    // _userId = null;
    _expiryDate = null;
    if (_auhtTimer != null) {
      _auhtTimer!.cancel();

      _auhtTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_auhtTimer != null) {
      _auhtTimer!.cancel();
      _auhtTimer = null;
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _auhtTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
