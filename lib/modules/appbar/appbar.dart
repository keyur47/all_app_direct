import 'dart:async';
import 'dart:developer';

import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/main.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/facebook_login/facebook_login.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/gmail_login/gmail_login.dart';
import 'package:all_app_direct/modules/Auth/logout/home_controller.dart';
import 'package:all_app_direct/modules/appbar/appbar_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/setting.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/share/shareapp.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customAppbar extends StatefulWidget {
  customAppbar(
      {required this.text,
      required this.icon,
      // required this.iconColor,
      required this.left,
      required this.right,
      required this.bottom,
      required this.directText,
      required this.top,
      required this.size});

  String text;
  IconData icon;

  // Color iconColor;
  double top;
  double bottom;
  double right;
  double left;
  double size;
  String directText;

  @override
  State<customAppbar> createState() => _customAppbarState();
}

class _customAppbarState extends State<customAppbar> {
  //
  AppbarController controller = Get.put(AppbarController());
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  HomeController homeController = Get.find();
  ThemeController themeController = Get.find();
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTimeOut();
  }

  // void startTimeOut() {
  //   Timer(
  //     Duration(seconds: 3),
  //     () {
  //       // Navigation.pushNamed(Routes.homePage);
  //       print("---splashscreen---");
  //     },
  //   );
  // }


  void timeDelay() {
    Future.delayed(const Duration(seconds: 3), () async {
        controller.isLoading.value ? CircularProgressIndicator():
        Navigation.pushNamed(Routes.instagram);
      }
    );}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeUtils.horizontalBlockSize * 4,
                top: SizeUtils.horizontalBlockSize * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   // _key.currentState?.showButtonMenu();
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeController.isSwitched.value
                                ? AppColor.grey[200]
                                : AppColor.darkBlue,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(4, 6), // Shadow position
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: widget.top,
                                bottom: widget.bottom,
                                right: widget.right,
                                left: widget.left),
                            child: Icon(
                              widget.icon,
                              size: widget.size,
                              color: themeController.isSwitched.value
                                  ? AppColor.white
                                  : AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeUtils.horizontalBlockSize * 2,
                      ),
                      Text(
                        widget.directText,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Customtext",
                            color: themeController.isSwitched.value
                                ? AppColor.white
                                : AppColor.darkBlue,
                            fontWeight: FontWeight.w700),
                      ),
                      PopupMenuButton<int>(
                        key: _key,
                        elevation: themeController.isSwitched.value ? 0 : 20,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: themeController.isSwitched.value
                              ? AppColor.white
                              : AppColor.darkBlue,
                        ),
                        onSelected: (int value) async {
                          controller.popupMenuItemIndex.value = value;
                          if (controller.popupMenuItemIndex.value == 1) {
                            Navigation.pushNamed(Routes.whatsapp);
                          } else if (controller.popupMenuItemIndex.value == 2) {
                            Navigation.pushNamed(Routes.instagram);
                            // if(controller.isLoading.value){
                            //   controller.isLoading.value  == false;
                            //   Future.delayed(const Duration(seconds: 4)).
                            //   Navigation.pushNamed(Routes.instagram);
                            // }else{
                            //   controller.isLoading.value = false;
                            // }
                          } else if (controller.popupMenuItemIndex.value == 3) {
                            Navigation.pushNamed(Routes.telegram);
                          } else if (controller.popupMenuItemIndex.value == 4) {
                            Navigation.pushNamed(Routes.snapchat);
                          } else if (controller.popupMenuItemIndex.value == 5) {
                            Navigation.pushNamed(Routes.galleryFileImage);
                          } else {}
                          controller.pageIndex.value =
                              controller.popupMenuItemIndex.value;
                          print("Value:- $value");
                          print(
                              "Value12:- ${controller.popupMenuItemIndex.value}");
                          print("Value19:- ${controller.pageIndex.value}");
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            value: 1,
                            child: Center(
                                child: Obx(
                              () => Text(
                                StringsUtils.whatsApp,
                                style: TextStyle(
                                  color: themeController.isSwitched.value
                                      ? AppColor.white
                                      : AppColor.darkBlue,
                                ),
                              ),
                            )),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            value: 2,
                            child: Center(
                                child: Obx(
                              () => Text(StringsUtils.instagram,
                                  style: TextStyle(
                                    color: themeController.isSwitched.value
                                        ? AppColor.white
                                        : AppColor.darkBlue,
                                  )),
                            )),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            value: 3,
                            child: Center(
                                child: Text(StringsUtils.telegram,
                                    style: TextStyle(
                                      color: themeController.isSwitched.value
                                          ? AppColor.white
                                          : AppColor.darkBlue,
                                    ))),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            value: 4,
                            child: Center(
                                child: Text(StringsUtils.snapchat,
                                    style: TextStyle(
                                      color: themeController.isSwitched.value
                                          ? AppColor.white
                                          : AppColor.darkBlue,
                                    ))),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.zero,
                            value: 5,
                            child: Center(
                                child: Text(StringsUtils.gallery,
                                    style: TextStyle(
                                      color: themeController.isSwitched.value
                                          ? AppColor.white
                                          : AppColor.darkBlue,
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  elevation: themeController.isSwitched.value ? 0 : 20,
                  onSelected: (int value) async {
                    if (value == 1) {
                      Get.to(Setting());
                    } else if (value == 2) {
                      Share();
                    } else if (value == 3) {
                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      } else {
                        AppToast.toastMessage(
                            "app review not available at time.");
                      }
                    } else if (value == 4) {
                    } else if (value == 5) {
                    } else {
                      sp = await SharedPreferences.getInstance();
                      isUserLogin = sp.setBool('login', false);
                      log('spout-----${sp.getBool('login')}');
                      for (final providerProfile
                          in FirebaseAuth.instance.currentUser!.providerData) {
                        // ID of the provider (google.com, apple.cpm, etc.)
                        final provider = providerProfile.providerId;
                        try {
                          homeController.logOutLoading.value = true;
                          if (provider == 'google.com') {
                            log("logout with google");
                            FirebaseService service = FirebaseService();
                            await service.signOutFromGoogle();
                          } else if (provider == 'facebook.com') {
                            log("logout with facebook");
                            await signOutFromFacebook();
                          } else {
                            log("logout with other");
                            homeController.logOut();
                          }
                        } on FirebaseAuthException catch (e) {
                          log("----SignOut------${e.toString()}");
                          getSnackBar("Some error accrues", "Please try again",
                              Colors.red.shade500, 3);
                        } catch (e) {
                          getSnackBar("Some error accrues", "Please try again",
                              Colors.red.shade500, 3);

                          log("drawerLogOut---->${e.toString()}");
                        } finally {
                          homeController.logOutLoading.value = false;
                        }
                      }
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
                    const PopupMenuItem(
                      value: 2,
                      child: Text(StringsUtils.shareApp),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text(StringsUtils.rateApp),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text(StringsUtils.feedback),
                    ),
                    const PopupMenuItem(
                      value: 5,
                      child: Text(StringsUtils.termsAndPrivacy),
                    ),
                    const PopupMenuItem(
                      value: 6,
                      child: Text(StringsUtils.logout),
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
                color: AppColor.backgroundColorScreen),
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
                color: AppColor.backgroundColorScreen),
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
