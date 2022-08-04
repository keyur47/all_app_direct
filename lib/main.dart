import 'dart:developer';

import 'package:all_app_direct/direct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/shared_preferences.dart';

late SharedPreferences sp;
var isUserLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initSp();
  await Firebase.initializeApp();
  await SharedPrefs.initMySharedPreferences();
  runApp(Direct());
}

initSp() async {
  sp = await SharedPreferences.getInstance();
  isUserLogin = sp.getBool('login');
  log('mainSPValue-----${sp.getBool('login')}');
}