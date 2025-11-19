import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController();
  static const _localeKey = 'locale_code';
  Locale _locale = const Locale('en', 'US');
  Locale get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code != null && code.isNotEmpty) {
      final parts = code.split('_');
      _locale = Locale(parts.first, parts.length > 1 ? parts[1] : null);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _localeKey, '${locale.languageCode}_${locale.countryCode ?? ''}');
  }
}
