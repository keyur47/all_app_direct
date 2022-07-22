import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/splashscreen/splash_screen_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<AllScreenController>(AllScreenController());
    Get.put<AdController>(AdController());
  }
}
