import 'package:shared_preferences/shared_preferences.dart';

class SavedPreferences {
  SavedPreferences._();
  static final SavedPreferences instance = SavedPreferences._();

  late SharedPreferences preferences;

  Future<void> initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  void saveString(String key, String value) async {
    await preferences.setString(key, value);
  }

  String? fetchString(String key) {
    return preferences.getString(key);
  }

  void saveInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  int? fetchInt(String key) {
    return preferences.getInt(key);
  }

  void saveBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  bool? fetchBool(String key) {
    return preferences.getBool(key);
  }

  void resetValue(String key) async {
    await preferences.remove(key);
  }
}
