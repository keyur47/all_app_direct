import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

/// Snackbar
SnackbarController getSnackBar(title, subtitle, backgroundColor, time) {
  return Get.snackbar(
    title,
    subtitle,
    icon: const Icon(Icons.person, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: time ?? 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

/// AppToast
class AppToast {
  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14);
  }
}

///  noData
Widget noData() {
  return Image.asset(
    AssetsPath.noData,
    height: SizeUtils.verticalBlockSize * 30,
  );
}




Widget lottie() {
  return Container(
    height: SizeUtils.verticalBlockSize * 100,
    color: Colors.grey.withOpacity(0.5),
    child: Align(
      alignment: Alignment.center,
      child: Lottie.asset("assets/lottie/lottie4.json", repeat: true,height: 150,
        reverse: true,
        animate: true,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.colorFilter(
              ['wave_2 Outlines', '**'],
              value: ColorFilter.mode(Colors.blue, BlendMode.src),
            ),
          ],
        ),
      ),
    ),
  );
}
