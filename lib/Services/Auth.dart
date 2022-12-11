import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

import '../Exceptions/HttpException.dart';
import '../Config/Url.dart';

class Auth with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;

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
    final data = jsonDecode(_response.body);

    _userId = data['user']['id'].toString();
    _token = data['user']['token'];
    _expiryDate = DateTime.tryParse(data['user']['token_expiration']);
    Url.token = _token!;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    return _request(email, password, 'register');
  }

  Future<void> login(email, password) async {
    return _request(email, password, 'login');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    Url.token = '';
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }
}
