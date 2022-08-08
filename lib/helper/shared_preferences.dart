import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {


  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static Future setInt( int value) async {
    await _prefs.setInt("onbording", value);
  }

  static int? getInt() {
    final int? value = _prefs.getInt("onbording");
    return value;
  }

  static Future setBoolean(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  static bool getBoolean(String key) {
    final bool? value = _prefs.getBool(key);
    return value ?? false;
  }


  static late SharedPreferences _prefs;

  static final Future<SharedPreferences> prefsData = SharedPreferences.getInstance();

  static Future<void> setNumberList(List<String> numberList) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setStringList("numberList", numberList);
  }

  static Future<List<String>> getNumberList() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getStringList("numberList") ?? [];
  }

  static Future<void> setInstagramList(List<String> InstagramList) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setStringList("InstagramList", InstagramList);
  }

  static Future<List<String>> getInstagramList() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getStringList("InstagramList") ?? [];
  }

  static Future<void> setTelegramList(List<String> Telegram) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setStringList("Telegram", Telegram);
  }

  static Future<List<String>> getTelegramList() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getStringList("Telegram") ?? [];
  }

  static Future<void> setSnapchatList(List<String> snapchat) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setStringList("snapchat", snapchat);
  }

  static Future<List<String>> getSnapchatList() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getStringList("snapchat") ?? [];
  }







  // static Future<bool> setSaveUserData(bool value) async {
  //   final SharedPreferences prefs = await prefsData;
  //   return await prefs.setBool('flag', value);
  // }
  //
  // static Future getSaveUserData() async {
  //   final SharedPreferences prefs = await prefsData;
  //   prefs.getBool("flag") ?? false;
  // }

  static Future<void> remove() async {
    final SharedPreferences prefs = await prefsData;
    await prefs.remove("numberList");
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await prefsData;
    await prefs.clear();
  }
}
