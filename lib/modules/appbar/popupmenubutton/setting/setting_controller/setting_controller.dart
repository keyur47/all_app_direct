import 'package:get/get.dart';
import '../../../../../helper/shared_preferences.dart';

class SettingController extends GetxController{
  RxBool isNotificationCheck = false.obs;

  void onInit() {
    super.onInit();
    isNotificationCheck.value = SharedPrefs.notification;
  }
}