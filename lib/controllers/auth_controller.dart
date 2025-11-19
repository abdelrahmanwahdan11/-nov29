import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/mock/mock_data.dart';
import '../data/models/user.dart';

class AuthController extends ChangeNotifier {
  AuthController();

  static const _loginKey = 'is_logged_in';
  static const _userKey = 'user_profile';
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  User? _user = demoUser;
  User? get user => _user;
  bool isLoading = false;
  String? error;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_loginKey) ?? false;
    final cached = prefs.getString(_userKey);
    if (cached != null) {
      _user = User.fromJson(cached);
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || !email.contains('@') || password.length < 4) {
      error = 'Invalid credentials';
    } else {
      _isLoggedIn = true;
      _user = demoUser.copyWith(email: email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginKey, true);
      await prefs.setString(_userKey, _user!.toJson());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (name.isEmpty || email.isEmpty || password.length < 6) {
      error = 'Fill all required fields';
    } else {
      _user = demoUser.copyWith(name: name, email: email);
      _isLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginKey, true);
      await prefs.setString(_userKey, _user!.toJson());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginKey);
    notifyListeners();
  }

  Future<void> continueAsGuest() async {
    _isLoggedIn = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, true);
    notifyListeners();
  }
}
