import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  ///TODO: Move it to a separate file and make sure to add key constants so that typos can be avoid
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'recommended_label': 'Recommended for you',
      'login_label': 'Log In',
    },
    'ja': {
      'recommended_label': 'あなたにおすすめ',
      'login_label': 'ログインする',
    }
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? '** $key not found';
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(
      AppLocalization(locale),
    );
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
