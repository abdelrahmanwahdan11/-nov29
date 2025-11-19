import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._primaryColor);

  static const _modeKey = 'theme_mode';
  static const _primaryKey = 'primary_color_hex';
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_modeKey);
    if (savedMode != null) {
      _mode = ThemeMode.values.firstWhere(
        (element) => element.name == savedMode,
        orElse: () => ThemeMode.light,
      );
    }
    final savedColor = prefs.getString(_primaryKey);
    if (savedColor != null) {
      _primaryColor = _fromHex(savedColor);
    }
    notifyListeners();
  }

  Future<void> updateMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode.name);
  }

  Future<void> updatePrimary(Color color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_primaryKey, _toHex(color));
  }

  static Color _fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String _toHex(Color color) =>
      '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
}
