import 'dart:developer';

import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/ads/ads_new.dart';
import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/modules/openbutton/open_username_instagram.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Instagram extends StatefulWidget {
  const Instagram({Key? key}) : super(key: key);

  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  AllScreenController controller = Get.find();
  AdController  adController = Get.find();
   ThemeController themeController = Get.find();


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log("home Screen test");
      if (message != null) {
        // if (message.data["page"] == "example") {
        //   // Get.to(const NotificationOpenScreen());
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigation.popAndPushNamed(Routes.whatsapp);
        return false;
      },
      child: Scaffold(
        backgroundColor:ColorRes.backgroundColor(context),        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                customAppbar(
                  text: StringsUtils.instagramDirects,
                  icon: BootstrapIcons.instagram,
                  top: SizeUtils.horizontalBlockSize * 1,
                  bottom: SizeUtils.horizontalBlockSize * 2,
                  right: SizeUtils.horizontalBlockSize * 1.5,
                  left: SizeUtils.horizontalBlockSize * 1.6,
                  size: SizeUtils.horizontalBlockSize * 10,
                  directText: StringsUtils.instagramDirects,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeUtils.horizontalBlockSize * 4,
                      right: SizeUtils.horizontalBlockSize * 4,
                      top: SizeUtils.horizontalBlockSize * 3),
                  child: Column(
                    children: [
                      usernameTextField(
                          controller: controller.instagramUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.instagramUsernameController.text = controller.instagramUsernameController.text.substring(0, controller.instagramUsernameController.text.length - 1);
                          },
                          longPress: () async {
                            controller.instagramUsernameController.clear();
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 4,
                ),
                GestureDetector(
                    onTap: (){
                      Get.to(AdsADs());
                    },
                    child:  Icon(Icons.arrow_back)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [OpenUserNameInstagram()],
                ),
                Expanded(
                    child: Obx(()=>
                       controller.getInstagramUsernameList.isNotEmpty
                          ? AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                                controller:
                                    AllScreenController.myContactScrollController,
                                padding: EdgeInsets.zero,
                                itemCount:
                                    controller.getInstagramUsernameList.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: const Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      duration: const Duration(milliseconds: 800),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration: const Duration(milliseconds: 1000),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeUtils.horizontalBlockSize * 2.4,
                                              top: SizeUtils.verticalBlockSize * 1.2,
                                              right: SizeUtils.horizontalBlockSize * 2),
                                          child: GestureDetector(
                                            child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeUtils.horizontalBlockSize * 2,
                                                    // top: SizeUtils.verticalBlockSize * 1,
                                                    // bottom: SizeUtils.verticalBlockSize * 1,
                                                    right: SizeUtils.horizontalBlockSize *
                                                        2),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: themeController.isSwitched.value ? AppColor.white : AppColor.darkBlue,
                                                      child: Text(
                                                        "${controller.getInstagramUsernameList[index]}"
                                                            .substring(0, 1)
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                5,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          SizeUtils.horizontalBlockSize *
                                                              3,
                                                    ),
                                                    Expanded(
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              controller.textController
                                                                      .text =
                                                                  "${controller.getInstagramUsernameList[index]}";
                                                            },
                                                            onLongPress: ()async{
                                                              controller.url.value =
                                                              "instagram://user?username=${controller.getInstagramUsernameList[index]}";
                                                              await launch(
                                                                  controller.url.value);
                                                              print(
                                                                  "------${controller.url.value}");
                                                            },
                                                            child: Text(
                                                              "${controller.getInstagramUsernameList[index]}",
                                                              style: TextStyle(
                                                                  fontSize: SizeUtils
                                                                          .horizontalBlockSize *
                                                                      4.5),
                                                            ))),
                                                    GestureDetector(

                                                      onTap: () async {
                                                        await controller.getInstagramUsernameList.removeAt(index)[index];
                                                        await SharedPrefs
                                                            .setInstagramList(controller
                                                            .getInstagramUsernameList.value);
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: AppColor.grey.withOpacity(0.5),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          )
                          : Center(child: noData()),
                    ))
              ],
            ),
            const BannerAds(),
          ],
        ),
      ),
    );
  }
}
