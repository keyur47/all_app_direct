import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/oepn_username_snapchat.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Snapchat extends StatefulWidget {

  @override
  _SnapchatState createState() => _SnapchatState();
}

class _SnapchatState extends State<Snapchat> {
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.telegram);
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
                  text: StringsUtils.snapchatDirects,
                  icon: Icons.snapchat,
                  iconColor: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.darkBlue,
                        AppColor.darkBlue,

                      ]),
                  top: SizeUtils.horizontalBlockSize *1,
                  bottom: SizeUtils.horizontalBlockSize *1.1,
                  right: SizeUtils.horizontalBlockSize *1.4,
                  left:SizeUtils.horizontalBlockSize * 1.4,
                  size: SizeUtils.horizontalBlockSize *10,
                  directText: StringsUtils.snapchatDirects,
                ),
                Padding(
                  padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4, right:SizeUtils.horizontalBlockSize *  4, top:SizeUtils.horizontalBlockSize *  2),
                  child: Column(
                    children: [
                      usernameTextField(
                          controller: controller.snapchatUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.snapchatUsernameController.clear();
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize* 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [OpenUserNameSnapchat()],
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
