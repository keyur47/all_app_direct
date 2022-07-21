import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/open_username_instagram.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Instagram extends StatefulWidget {

  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.whatsapp);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                customAppbar(
                  text: StringsUtils.instagramDirects,
                  icon: Icons.android,
                  iconColor: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.darkBlue,
                        AppColor.darkBlue,
                        // Color(0xFF405DE6),
                        // Color(0xFF5851DB),
                        // Color(0xFF833AB4),
                        // Color(0xFFC13584),
                        // Color(0xFFE1306C),
                        // Color(0xFFFD1D1D),
                        // Color(0xFFF56040),
                        // Color(0xFFF77737),
                        // Color(0xFFFCAF45),
                        // Color(0xFFFFDC80),
                      ]),
                  top: SizeUtils.horizontalBlockSize *1,
                  bottom: SizeUtils.horizontalBlockSize *1,
                  right:SizeUtils.horizontalBlockSize * 1.2,
                  left: SizeUtils.horizontalBlockSize *1.4,
                  size: SizeUtils.horizontalBlockSize *10,
                  directText: StringsUtils.instagramDirects,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4, right:SizeUtils.horizontalBlockSize *  4, top:SizeUtils.horizontalBlockSize *  2),
                  child: Column(
                    children: [
                      usernameTextField(
                          controller: controller.instagramUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.instagramUsernameController.clear();
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [OpenUserNameInstagram()],
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