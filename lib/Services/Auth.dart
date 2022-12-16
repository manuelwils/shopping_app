import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/HttpException.dart';
import '../Config/Url.dart';

class Auth with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;
  Timer? _timer;

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token!;
    }
    return null;
  }

  Future<void> _request(email, password, String endpoint) async {
    final _route = Uri.parse(Url.to['auth']![endpoint]!);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    final Map<String, String> body = {
      'email': email,
      'password': password,
      'device_name': androidInfo.model,
    };

    final _response = await http.post(
      _route,
      body: jsonEncode(body),
      headers: Url().headers,
    );

    if (_response.statusCode >= 400) {
      final errors = jsonDecode(_response.body);
      throw const HttpException('could not authenticate');
    }
    final _data = jsonDecode(_response.body);

    _userId = _data['user']['id'].toString();
    _token = _data['user']['token'];
    _expiryDate = DateTime.tryParse(_data['user']['token_expiration']);
    Url.token = _token!;

    _autoLogout();
    notifyListeners();

    final _prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> _userData = {
      'id': _userId!,
      'token': _token!,
      'expiryDate': _expiryDate!.toIso8601String(),
    };
    _prefs.setString('userData', jsonEncode(_userData));
  }

  Future<void> signUp(String email, String password) async {
    return _request(email, password, 'register');
  }

  Future<void> login(email, password) async {
    return _request(email, password, 'login');
  }

  Future<void> logout() async {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _token = null;
    _userId = null;
    _expiryDate = null;
    Url.token = '';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (_timer != null) {
      _timer!.cancel();
    }
    final _logoutTime = _expiryDate!.difference(DateTime.now()).inSeconds;
    _timer = Timer(
      Duration(seconds: _logoutTime),
      logout,
    );
  }

  Future<bool> tryAutoLogin() async {
    final _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('userData')) {
      return false;
    }
    final _userData =
        jsonDecode(_prefs.getString('userData')!) as Map<String, dynamic>;
    final expDate = DateTime.parse(_userData['expiryDate']);
    if (expDate.isBefore(DateTime.now()) || _userData['token'] == '') {
      return false;
    }
    _userId = _userData['id'].toString();
    _token = _userData['token'];
    _expiryDate = DateTime.tryParse(_userData['expiryDate']);
    Url.token = _token!;
    notifyListeners();
    _autoLogout();
    return true;
  }

  bool get isAuth {
    return token != null;
  }
}
