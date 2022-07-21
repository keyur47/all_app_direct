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

  static Future<void> setStringData(String lastName) async {
    final SharedPreferences prefs = await prefsData;
    prefs.setString("StringData", lastName);
  }

  static Future getStringData() async {
    final SharedPreferences prefs = await prefsData;
    prefs.getString("StringData");
  }

  static Future<void> remove() async {
    final SharedPreferences prefs = await prefsData;
    await prefs.remove("numberList");
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await prefsData;
    await prefs.clear();
  }
}
