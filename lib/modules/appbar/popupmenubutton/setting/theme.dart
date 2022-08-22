import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isSwitched = false.obs;

  // static bool isDarkMode = false;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    getTheme();

    super.onInit();
  }

  ThemeMode setTheme() {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  void getTheme() {
    isSwitched.value = SharedPrefs.getThemeBoolean("theme");
    isDarkMode.value = isSwitched.value;
  }

}