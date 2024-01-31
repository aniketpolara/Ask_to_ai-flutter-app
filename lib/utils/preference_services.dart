import 'package:shared_preferences/shared_preferences.dart';

class PreferenceServices {
  static const isFirstTime = "isFirstTime";
  static const chatTextCount = "chatTextCount";
  static const imageCount = "imageCount";
  static const textCompletionCount = "textCompletionCount";

  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static bool getBool(String key) {
    return pref.getBool(key) ?? false;
  }

  static Future<void> setBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  static String getString(String key) {
    return pref.getString(key) ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  static Future<void> clearSharPreference() async {
    await pref.clear();
  }

  static Future<void> clearKeyData(String key) async {
    await pref.remove(key);
  }
}
