import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    // Navigation.popAndPushNamed(Routes.dashBordScreen);
    checkFirstSeen();
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
      Navigation.popAndPushNamed(Routes.whatsapp);

      // String? token1 = await SharedPrefs.getUser();
      // if (token1?.isNotEmpty ?? false) {
      //   Navigation.popAndPushNamed(Routes.dashBordScreen);
      // } else {
      //   Navigation.popAndPushNamed(Routes.signInScreen);
      // }
      // I am connected to a mobile network.
      log("I am connected to a mobile network");
    } else if (result == ConnectivityResult.wifi) {
      Navigation.popAndPushNamed(Routes.whatsapp);

      // String? token1 = await SharedPrefs.getUser();
      // if (token1?.isNotEmpty ?? false) {
      //   Navigation.popAndPushNamed(Routes.dashBordScreen);
      // } else {
      //   Navigation.popAndPushNamed(Routes.signInScreen);
      // }
      log("I am connected to a wifi network");
      // I am connected to a wifi network.
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
