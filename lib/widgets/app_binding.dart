import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/setting_controller/setting_controller.dart';
import 'package:all_app_direct/modules/Auth/controller/forget_password_controller.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_in_controller.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_up_controller.dart';
import 'package:all_app_direct/modules/Auth/logout/home_controller.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/modules/splashscreen/splash_screen_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LogInController>(LogInController());
    Get.put<SettingController>(SettingController());
    Get.put<SignUpController>(SignUpController());
    Get.put<HomeController>(HomeController());
    Get.put<ForgetPasswordController>(ForgetPasswordController());
    Get.put<SplashController>(SplashController());
    Get.put<AllScreenController>(AllScreenController());
  }
}
