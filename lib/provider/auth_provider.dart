import 'package:flutter/material.dart';
import 'package:frontend/controller/auth.dart';
import 'package:frontend/model/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  User? _user;
  String? _token;

  AuthProvider(this._authService);

  User? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _user = result['user'];
    _token = result['token'];
    notifyListeners();
  }

  Future<void> register(String username, String email, String password, String role) async {
    final result = await _authService.register(username, email, password, role);
    _user = result['user'];
    _token = result['token'];
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _token = null;
    notifyListeners();
  }
}
