
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
          if (controller
              .instagramUsernameController.text.isNotEmpty) {
            await adController.createRewardedAd();
            controller.setInstagramUsernameList.addAll([(controller.instagramUsernameController.text)]);
            SharedPrefs.setInstagramList(controller.setInstagramUsernameList);
            controller.url.value = "instagram://user?username=${controller.instagramUsernameController.text}";
            await launch(controller.url.value);
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
        iconData: BootstrapIcons.instagram,
      scale: SizeUtils.horizontalBlockSize* 3,
      top: SizeUtils.horizontalBlockSize*  2,
      left: SizeUtils.horizontalBlockSize* 4,
      right: SizeUtils.horizontalBlockSize* 1,
      bottom: SizeUtils.horizontalBlockSize* 2.4,
        boxColor: AppColor.white,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,colors: [
                  Colors.white,
                  Colors.white,
            ]),
            borderRadius: BorderRadius.circular(5)
        ),
        iconColor:  AppColor.appColors,);
  }
}


