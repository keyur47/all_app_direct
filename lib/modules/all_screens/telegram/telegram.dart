

import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/open_username_telegram.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Telegram extends StatefulWidget {

  @override
  _TelegramState createState() => _TelegramState();
}

class _TelegramState extends State<Telegram> {
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.instagram);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customAppbar(
                  text: StringsUtils.telegramDirects,
                  icon: Icons.telegram,
                  iconColor: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.darkBlue,
                        AppColor.darkBlue,
                      ]),
                  top: SizeUtils.horizontalBlockSize *1,
                  bottom: SizeUtils.horizontalBlockSize *1,
                  right: SizeUtils.horizontalBlockSize *1.1,
                  left: SizeUtils.horizontalBlockSize *1.1,
                  size: SizeUtils.horizontalBlockSize *10,
                  directText: StringsUtils.telegramDirects,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4, right:SizeUtils.horizontalBlockSize * 4, top:SizeUtils.horizontalBlockSize * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      usernameTextField(
                          controller: controller.telegramUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.telegramUsernameController.clear();
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OpenUserNameTelegram(),
                  ],
                ),
              ],
            ),
            Container(
              child:  BannerAds(),
            ),
          ],
        ),
      ),
    );
  }
}
