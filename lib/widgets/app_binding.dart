import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/login/controller/forget_password_controller.dart';
import 'package:all_app_direct/modules/login/controller/sign_in_controller.dart';
import 'package:all_app_direct/modules/login/controller/sign_up_controller.dart';
import 'package:all_app_direct/modules/login/logout/home_controller.dart';
import 'package:all_app_direct/modules/splashscreen/splash_screen_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LogInController>(LogInController());
    Get.put<SignUpController>(SignUpController());
    Get.put<HomeController>(HomeController());
    Get.put<ForgetPasswordController>(ForgetPasswordController());
    Get.put<SplashController>(SplashController());
    Get.put<AllScreenController>(AllScreenController());
    Get.put<AdController>(AdController());

  }
}
