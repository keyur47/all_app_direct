import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{
  RxBool isNotificationCheck = false.obs;

  void onInit() {
    super.onInit();
    isNotificationCheck.value = SharedPrefs.notification;
  }
}