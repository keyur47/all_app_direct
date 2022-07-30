import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/open_username_telegram.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:all_app_direct/widgets/nodata.dart';
import 'package:flutter/material.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //
  // getData() async {
  //   controller.setTelegramUsernameList.value = await SharedPrefs.getTelegramString();
  //   controller.getTelegramUsernameList.value =
  //       controller.setTelegramUsernameList.toSet().toList();
  //   setState(() {
  //     controller.setTelegramUsernameList.join("");
  //     controller.getTelegramUsernameList.join("");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigation.popAndPushNamed(Routes.instagram);
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
                      top: SizeUtils.horizontalBlockSize * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      usernameTextField(
                          controller: controller.telegramUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.telegramUsernameController.text =
                                controller.telegramUsernameController.text
                                    .substring(
                                        0,
                                        controller.telegramUsernameController
                                                .text.length -
                                            1);
                          },
                          longPress: () async {
                            controller.telegramUsernameController.clear();
                          }),
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
                                                      AppColor.darkBlue,
                                                  child: Text(
                                                    "${controller.getTelegramUsernameList[index]}"
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: AppColor.white,
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
