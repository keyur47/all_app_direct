import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final Future<SharedPreferences> prefsData =
      SharedPreferences.getInstance();

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
