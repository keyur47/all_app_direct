import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUserNameSnapchat extends StatelessWidget {
  OpenUserNameSnapchat({Key? key}) : super(key: key);

  Controller controller = Get.find();
  AdController adController = Get.find();

  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
          if (controller
              .snapchatUsernameController.text.isNotEmpty){
            await adController.createRewardedAd();
            controller.url.value = "https://www.snapchat.com/add/${controller.snapchatUsernameController.text}/";
            await launch(controller.url.value);
            print("------${controller.url.value}");
          } else {
            AppSnackBar.showErrorSnackBar(
              Icon: const Icon(Icons.people_alt_rounded,color: Colors.blue),
              message: StringsUtils.pleaseUsername,
              title: StringsUtils.userNameTelegram,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        text: StringsUtils.snapchat,
        iconData: Icons.snapchat,
        scale: SizeUtils.horizontalBlockSize* 3,
        top: SizeUtils.horizontalBlockSize*  2,
        left: SizeUtils.horizontalBlockSize* 2,
        right: SizeUtils.horizontalBlockSize* 1,
        bottom: SizeUtils.horizontalBlockSize* 2,
        boxColor: AppColor.white,
        textColor: AppColor.black,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,colors: [
              Colors.white,
              Colors.white,
            ]),
            borderRadius: BorderRadius.circular(5)
        ),
        iconColor: const Color(0xFF28D146));
  }
}


