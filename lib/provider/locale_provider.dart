import 'package:apex_demo/constants/preferences_keys.dart';
import 'package:apex_demo/services/saved_preferences.dart';
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  final SavedPreferences _preferences = SavedPreferences.instance;
  Locale? _locale;
  Locale? get locale => _locale;

  void fetchSavedLocale() async {
    String? savedLocale = _preferences.fetchString(PreferencesKeys.selectedLocale);
    Locale _getLocale = _processLocale(savedLocale ?? "en");
    _locale = _getLocale;
    print(_locale!.languageCode);
  }

  void changeLocale(String languageCode) async {
    Locale _language = await setLocale(languageCode);
    _locale = _language;
    notifyListeners();
  }

  Locale _processLocale(String? languageCode) {
    return languageCode != null && languageCode.isNotEmpty ? Locale(languageCode, '') : const Locale('en', '');
  }

  Future<Locale> setLocale(String? languageCode) async {
    _preferences.saveString(PreferencesKeys.selectedLocale, languageCode!);
    return _processLocale(languageCode);
  }
}
