import 'package:all_app_direct/modules/appbar/appbar_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/feedback/feedback.dart';

import 'package:all_app_direct/modules/appbar/popupmenubutton/rate/rate.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/share/shareapp.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

  class customAppbar extends StatelessWidget {
    customAppbar(
        {required this.text,
        required this.icon,
        required this.iconColor,
        required this.gradient,
        required this.left,
        required this.right,
        required this.bottom,
        required this.directText,
        required this.top,
        required this.size});

    String text;
    IconData icon;
    Color iconColor;
    Gradient gradient;
    double top;
    double bottom;
    double right;
    double left;
    double size;
    String directText;

    //
    // List data = [
    //   (StringsUtils.whatsDirects),
    //   (StringsUtils.whatsDirects),
    //   (StringsUtils.instagramDirects),
    //   (StringsUtils.telegramDirects),
    //   (StringsUtils.smsDirects),
    // ];
    AppbarController controller = Get.put(AppbarController());
      final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: SizeUtils.horizontalBlockSize *4, top:SizeUtils.horizontalBlockSize *1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // _key.currentState?.showButtonMenu();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(4, 6), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              gradient: gradient),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: top,
                                bottom: bottom,
                                right: right,
                                left: left),
                            child: Icon(
                              icon,
                              size: size,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                         SizedBox(
                          width: SizeUtils.horizontalBlockSize *2,
                        ),
                        Text(
                          directText,
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Customtext",
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.w700),
                        ),
                        PopupMenuButton<int>(
                          key: _key,
                          elevation: 20,
                          child: const Icon(Icons.arrow_drop_down),
                          onSelected: (int value) async{
                            controller.popupMenuItemIndex.value = value;
                            if (controller.popupMenuItemIndex.value == 1) {
                              Get.toNamed(Routes.whatsapp);
                            } else if (controller.popupMenuItemIndex.value == 2) {
                              Get.toNamed(Routes.instagram);
                            } else if (controller.popupMenuItemIndex.value == 3) {
                              Get.toNamed(Routes.telegram);
                            } else if (controller.popupMenuItemIndex.value == 4) {
                              Get.toNamed(Routes.snapchat);
                            }  else {}
                            controller.pageIndex.value =
                                controller.popupMenuItemIndex.value;
                            print("Value:- $value");
                            print("Value12:- ${controller.popupMenuItemIndex.value}");
                            print("Value19:- ${controller.pageIndex.value}");
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              padding: EdgeInsets.zero,
                              value: 1,
                              child: Center(child: Text(StringsUtils.whatsApp,style: TextStyle(color: AppColor.darkBlue,fontFamily: "Customtext"),)),
                            ),
                            const PopupMenuItem(
                              padding: EdgeInsets.zero,
                              value: 2,
                              child: Center(child: Text(StringsUtils.instagram,style: TextStyle(color: AppColor.darkBlue,fontFamily: "Customtext"))),
                            ),
                            const PopupMenuItem(
                              padding: EdgeInsets.zero,
                              value: 3,
                              child: Center(child: Text(StringsUtils.telegram,style: TextStyle(color: AppColor.darkBlue,fontFamily: "Customtext"))),
                            ),
                            const PopupMenuItem(
                              padding: EdgeInsets.zero,
                              value: 4,
                              child: Center(child: Text(StringsUtils.snapchat,style: TextStyle(color: AppColor.darkBlue,fontFamily: "Customtext"))),
                            ),
                          ],
                        ),
                    ],
                  ),
                  PopupMenuButton(
                    onSelected: (int value) {
                      if (value == 1) {
                        // Get.toNamed(Routes.tabbar);
                      } else if (value == 2) {
                        Share();
                      } else if (value == 3) {
                        RateBox(context);
                      } else if (value == 4) {
                        FeedbackBox(context);
                      }else {
                        // Get.to(const About());
                      }
                      controller.pageIndex.value =
                          controller.popupMenuItemIndex.value;
                      if (kDebugMode) {
                        print("Value:- $value");
                      }
                      if (kDebugMode) {
                        print("Value12:- ${controller.popupMenuItemIndex.value}");
                      }
                      if (kDebugMode) {
                        print("Value19:- ${controller.pageIndex.value}");
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text(StringsUtils.history),
                      ),
                      const   PopupMenuItem(
                        value: 2,
                        child: Text(StringsUtils.shareApp),
                      ),
                      const  PopupMenuItem(
                        value: 3,
                        child: Text(StringsUtils.rateApp),
                      ),
                      const    PopupMenuItem(
                        value: 4,
                        child: Text(StringsUtils.feedback),
                      ),
                      const  PopupMenuItem(
                        value: 5,
                        child: Text(StringsUtils.termsAndPrivacy),
                      ),
                      const   PopupMenuItem(
                        value: 6,
                        child: Text(StringsUtils.aboutApp),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

Widget contactsAppbar({required String text, IconData? iconData}) {
  return Container(
    color: AppColor.darkBlue,
    child: Padding(
      padding: EdgeInsets.only(
        top: 6,
        bottom: 1,
        left: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                iconData,
                color: Colors.white,
              )),
          SizedBox(
            width: 1,
          ),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 22.0,
                fontFamily: 'Customtext',
                color: AppColor.backgroundColor),
            child: AnimatedTextKit(
              pause: Duration(milliseconds: 100),
              animatedTexts: [
                TypewriterAnimatedText(text),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget usernameAppbar({required String text}) {
  return Container(
    color: AppColor.darkBlue,
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 6,
            bottom: 1,
            left: 4,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 22.0,
                fontFamily: 'Customtext',
                color: AppColor.backgroundColor),
            child: AnimatedTextKit(
              pause: Duration(milliseconds: 100),
              animatedTexts: [
                TypewriterAnimatedText(text),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
