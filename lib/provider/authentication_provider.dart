import 'package:apex_demo/constants/page_paths.dart';
import 'package:apex_demo/constants/preferences_keys.dart';
import 'package:apex_demo/services/saved_preferences.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  final SavedPreferences _preferences = SavedPreferences.instance;

  bool get isUserSignedIn {
    bool? userLoggedStatus = _preferences.fetchBool(PreferencesKeys.isUserLoggedIn);
    if (userLoggedStatus != null && userLoggedStatus == true) {
      return true;
    } else {
      return false;
    }
  }

  void setUserLoggedInStatus(bool value) {
    _preferences.saveBool(PreferencesKeys.isUserLoggedIn, value);
    notifyListeners();
  }

  void clearUserLoggedInStatus() {
    _preferences.preferences.clear();
  }

  void loginUser(context) {
    setUserLoggedInStatus(true);
    Navigator.pushNamedAndRemoveUntil(context, PagePaths.homeScreen, (Route<dynamic> route) => false);
  }

  void logoutUser(context) {
    clearUserLoggedInStatus();
    Navigator.pushNamedAndRemoveUntil(context, PagePaths.loginScreen, (Route<dynamic> route) => false);
  }
}
