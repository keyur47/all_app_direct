import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUserNameTelegram extends StatelessWidget {
  OpenUserNameTelegram({Key? key}) : super(key: key);
  Controller controller = Get.find();
  AdController adController = Get.find();
  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
          if (controller.telegramUsernameController.text.isNotEmpty) {
            await adController.createRewardedAd();
            controller.url.value =
                "https://telegram.me/${controller.telegramUsernameController.text}";
            await launch(controller.url.value);
            print("------${controller.url.value}");
          } else {
            AppSnackBar.showErrorSnackBar(
              Icon: const Icon(Icons.people_alt_rounded, color: Colors.blue),
              message: StringsUtils.pleaseUsername,
              title: StringsUtils.userNameTelegram,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        text: StringsUtils.telegram,
        iconData: Icons.telegram_outlined,
        scale: 3,
        top: 1.1,
        left: 1.1,
        right: 1.1,
        bottom: 1.1,
        boxColor: AppColor.white,
        textColor: AppColor.black,
        iconColor:   const Color(0xFF28D146),
        // iconColor: Colors.blue,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white,
              ]),
        ),
        sizeIcon: 7);
  }
}
