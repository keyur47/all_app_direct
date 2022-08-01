import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static late SharedPreferences _prefs;

  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }



  static Future setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    final int? value = _prefs.getInt(key);
    return value;
  }


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

  static  setPage(int page) async {
    final SharedPreferences prefs = await prefsData;
    return prefs.setInt("page", page);
  }

  static Future<int> getPage() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getInt("page") ?? 0;
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
