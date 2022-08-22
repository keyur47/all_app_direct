import 'dart:developer';

import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool forgetPasswordLoading = false.obs;
  Duration kLoginAnimationDuration = Duration(milliseconds: 1000);
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  TextEditingController forgetPasswordEmail = TextEditingController();

  Future<User?> resetPassword({
    required String email,
  }) async {
    forgetPasswordLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      forgetPasswordEmail.clear();
      getSnackBar(
          "Please check your mail in INBOX/SPAM",
          "Reset password link has been successfully sent to email",
          Colors.green.shade400,
          3);

      Get.toNamed(Routes.loginPage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getSnackBar("User not found", "This email is not registered",
            Colors.red.shade500, 3);

        log('No user found for that email.');
      } else if (e.code == 'user-disabled') {
        getSnackBar("Your account has been disabled",
            "Try with different account", Colors.red.shade500, 3);

        log('Disable Account.');
      } else {
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);
      }
      log("---ForgetPassword-------${e.toString()}");
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("ForgetPAssworg---->${e.toString()}");
    } finally {
      forgetPasswordLoading.value = false;
    }
    return null;
  }
}
