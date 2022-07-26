import 'dart:io';

import 'package:all_app_direct/ads/banner_ad.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/modules/openbutton/open_username_telegram.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Telegram extends StatefulWidget {
  const Telegram({Key? key}) : super(key: key);

  @override
  _TelegramState createState() => _TelegramState();
}

class _TelegramState extends State<Telegram> {
  AllScreenController controller = Get.find();
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigation.popAndPushNamed(Routes.instagram);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.backgroundColor(context),
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
                  top: SizeUtils.horizontalBlockSize * 1,
                  bottom: SizeUtils.horizontalBlockSize * 1,
                  right: SizeUtils.horizontalBlockSize * 1.1,
                  left: SizeUtils.horizontalBlockSize * 1.1,
                  size: SizeUtils.horizontalBlockSize * 10,
                  directText: StringsUtils.telegramDirects,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeUtils.horizontalBlockSize * 4,
                      right: SizeUtils.horizontalBlockSize * 4,
                      top: SizeUtils.horizontalBlockSize * 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomeTextField(
                        isBoxShadow: true,
                        isSearch: true,
                        maxLine: 1,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: SizeUtils.horizontalBlockSize * 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  List<String> Username =
                                      await SharedPrefs.getTelegramList();
                                  var username = controller
                                      .telegramUsernameController
                                      .text = Username.last;
                                  print("Username:-  $username");
                                },
                                child: Icon(
                                  Icons.history,
                                  size: SizeUtils.verticalBlockSize * 3,
                                  color: AppColor.appIconColor,
                                ),
                              ),
                              Platform.isAndroid
                                  ? const SizedBox(
                                      width: 3,
                                    )
                                  : const SizedBox(),
                              GestureDetector(
                                  onTap: () async {
                                    controller.telegramUsernameController.text =
                                        controller
                                            .telegramUsernameController.text
                                            .substring(
                                                0,
                                                controller
                                                        .telegramUsernameController
                                                        .text
                                                        .length -
                                                    1);
                                  },
                                  onLongPress: () async {
                                    controller.telegramUsernameController
                                        .clear();
                                  },
                                  child: Icon(Icons.close,
                                      color: themeController.isSwitched.value
                                          ? AppColor.appIconColor
                                          : AppColor.appIconColor)),
                            ],
                          ),
                        ),
                        textInputFormatter: [
                          FilteringTextInputFormatter(RegExp(r'[a-z_.0-9]'),
                              allow: true)
                        ],
                        radius: SizeUtils.horizontalBlockSize * 10,
                        controller: controller.telegramUsernameController,
                        showCursor: false,
                        hintText: StringsUtils.username,
                        textInputType: TextInputType.none,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OpenUserNameTelegram(),
                  ],
                ),
                Expanded(
                    child: Obx(
                  () => controller.getTelegramUsernameList.isNotEmpty
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
                                controller.getTelegramUsernameList.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 300),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeUtils.horizontalBlockSize *
                                              2.4,
                                          top:
                                              SizeUtils.verticalBlockSize * 1.2,
                                          right: SizeUtils.horizontalBlockSize *
                                              2),
                                      child: GestureDetector(
                                        // onLongPress: (){
                                        //   setState(() {
                                        //     controller.delete.value !=  controller.delete.value;
                                        //   });
                                        // },
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //     color: controller. delete.value ? Colors.red : Colors.black12,
                                          //     borderRadius: BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: SizeUtils
                                                        .horizontalBlockSize *
                                                    2,
                                                top: SizeUtils
                                                        .verticalBlockSize *
                                                    0.7,
                                                bottom: SizeUtils
                                                        .verticalBlockSize *
                                                    0.7,
                                                right: SizeUtils
                                                        .horizontalBlockSize *
                                                    2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      themeController
                                                              .isSwitched.value
                                                          ? AppColor.white
                                                          : AppColor.darkBlue,
                                                  child: Text(
                                                    "${controller.getTelegramUsernameList[index]}"
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeUtils
                                                          .horizontalBlockSize *
                                                      3,
                                                ),
                                                Expanded(
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          controller
                                                                  .telegramUsernameController
                                                                  .text =
                                                              "${controller.getTelegramUsernameList[index]}";
                                                        },
                                                        onLongPress: () async {
                                                          controller.url.value =
                                                              "https://telegram.me/${controller.getTelegramUsernameList[index]}";
                                                          await launch(
                                                              controller
                                                                  .url.value);
                                                          print(
                                                              "------${controller.url.value}");
                                                        },
                                                        child: Text(
                                                          "${controller.getTelegramUsernameList[index]}",
                                                          style: TextStyle(
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  4.5),
                                                        ))),
                                                // GestureDetector(
                                                //   onTap: () async {
                                                //     controller.url.value =
                                                //         "instagram://user?username=${controller.getTelegramUsernameList[index]}";
                                                //     await launch(
                                                //         controller.url.value);
                                                //     print(
                                                //         "------${controller.url.value}");
                                                //   },
                                                //   child: Icon(
                                                //     BootstrapIcons.telegram,
                                                //     color: AppColor.appColors,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: SizeUtils
                                                          .horizontalBlockSize *
                                                      2,
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      await controller
                                                          .getTelegramUsernameList
                                                          .removeAt(
                                                              index)[index];
                                                      await SharedPrefs
                                                          .setTelegramList(
                                                              controller
                                                                  .getTelegramUsernameList);
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 18,
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                    ))
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
