
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class OpenUserNameInstagram extends StatelessWidget {
  OpenUserNameInstagram({Key? key}) : super(key: key);

  AllScreenController controller = Get.find();
  AdController adController = Get.find();
  ThemeController themeController = Get.find();
  final ValueNotifier<bool> isCheck = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isCheck,
        builder: (BuildContext context,bool value, _) {
      return button(
          onTap: () async {
            if (controller.instagramUsernameController.text.isNotEmpty) {
              await adController.createInterstitialAd();
              // await adController.createRewardedAd();
              controller.setInstagramUsernameList.addAll([(controller.instagramUsernameController.text)]);
              SharedPrefs.setInstagramList(controller.setInstagramUsernameList);
              controller.url.value = "instagram://user?username=${controller.instagramUsernameController.text}";
              await launch(controller.url.value);
              controller.getInstagramData();
              if (kDebugMode) {
                print("------${controller.url.value}");
              }
            } else {
              AppSnackBar.showErrorSnackBar(
                Icon: const Icon(Icons.people_alt_rounded,color: Colors.blue),
                message: StringsUtils.pleaseUsername,
                title: StringsUtils.userNameTelegram,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          text: StringsUtils.instagram,
        imageIcon: value,
        image: AssetsPath.instagram,
          imageColor: themeController.isSwitched.value ? AppColor.appGreen : AppColor.appGreen,
        scale: SizeUtils.horizontalBlockSize* 3,
        top: SizeUtils.horizontalBlockSize*  2,
        left: SizeUtils.horizontalBlockSize* 4,
        right: SizeUtils.horizontalBlockSize* 1,
        bottom: SizeUtils.horizontalBlockSize* 2.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)
          ));
        },
    );
  }
}


