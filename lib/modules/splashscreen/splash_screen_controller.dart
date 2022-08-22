import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:all_app_direct/ads/ads_new.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/main.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit()  {
    super.onInit();
    // Future.delayed(const Duration(seconds: 4),(){});
    // AppOpenAdManager.loadAd();
    // InterstitalAd.createInterstitialAd();
    // AppOpenAdManager.showOpenAdIfAvailable();
    // Navigation.popAndPushNamed(Routes.dashBordScreen);
    startTimeOut();
  }

  void startTimeOut() {
    Timer(
      const Duration(seconds: 3),
          () {
        // AppOpenAdManager.showOpenAdIfAvailable();
        InterstitalAd.createInterstitialAd();
        checkFirstSeen();
        // Navigation.pushNamed(Routes.homePage);
        print("---splashscreen---");
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future checkFirstSeen() async {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    result = await (Connectivity().checkConnectivity());

    if (result == ConnectivityResult.mobile) {

      final value = SharedPrefs.getInt() ?? 0;
      SharedPreferences sp = await SharedPreferences.getInstance();
      isUserLogin = await sp.getBool('login');

      value == 1
          ? isUserLogin == true || isUserLogin == "true"
          ? Navigation.popAndPushNamed(Routes.whatsapp):Navigation.popAndPushNamed(Routes.loginPage)
          : Navigation.popAndPushNamed(Routes.onboardingScreen);

      /// onboardingScreen
      // final value = SharedPrefs.getInt() ?? 0;
      // value == 1
      //     ? Navigation.popAndPushNamed(Routes.loginPage)
      //     : Navigation.popAndPushNamed(Routes.onboardingScreen);


      log("I am connected to a mobile network");
    } else if (result == ConnectivityResult.wifi) {

      final value = SharedPrefs.getInt() ?? 0;
      SharedPreferences sp = await SharedPreferences.getInstance();
      isUserLogin = await sp.getBool('login');
      value == 1
          ? isUserLogin == true || isUserLogin == "true"
          ? Navigation.popAndPushNamed(Routes.whatsapp):Navigation.popAndPushNamed(Routes.loginPage)
          : Navigation.popAndPushNamed(Routes.onboardingScreen);


      log("I am connected to a wifi network");
    } else {
      log("I am not connected to a mobile or Wifi network");
      return internetCheck();
    }
    return _updateConnectionStatus(result);
  }

  internetCheck() {
    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: AppColor.white,
          child: CheckNetwork(context),
        );
      },
    );
  }

  Widget CheckNetwork(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 3),
          child: Text(
            StringsUtils.internetCheckError,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.fSize_20()),
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey[90]!,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                initConnectivity();
                Get.back();
              },
              child: Text(
                StringsUtils.check,
                style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            Container(
              width: 1,
              height: 52,
              color: AppColor.grey[90]!,
            ),
            GestureDetector(
              onTap: () async {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: Text(
                StringsUtils.ok,
                style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
  }
}
