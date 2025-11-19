import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'PS'),
  ];

  static const _localizedStrings = {
    'en': {
      'home_title': 'Introducing NexRide – The Future of AI-Driven Mobility.',
      'login': 'Login',
      'signup': 'Create account',
      'guest_mode': 'Continue as guest',
      'catalog': 'Catalog',
      'my_trip': 'My Trip',
      'account': 'Account',
      'more': 'More',
      'ai': 'Nex-AI',
    },
    'ar': {
      'home_title': 'نكس رايد – مستقبل التنقّل المدعوم بالذكاء الاصطناعي.',
      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'guest_mode': 'المتابعة كضيف',
      'catalog': 'الكتالوج',
      'my_trip': 'رحلتي',
      'account': 'الحساب',
      'more': 'المزيد',
      'ai': 'نكس-ذكاء',
    },
  };

  String translate(String key) {
    return _localizedStrings[locale.languageCode]?[key] ??
        _localizedStrings['en']![key] ??
        key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
