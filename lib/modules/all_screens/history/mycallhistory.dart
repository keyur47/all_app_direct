import 'dart:io';

import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCallHistory extends StatelessWidget {
  MyCallHistory({Key? key}) : super(key: key);
  final AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).copyWith(dividerColor: Colors.transparent); //new
    return Obx(
      () => AnimationLimiter(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),

          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: AllScreenController.myCallScrollController,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 50),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 50),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 50),
                  child: Theme(
                    data: theme,
                    child: ExpansionTile(
                      trailing: GestureDetector(
                          onTap: () async {
                            controller.url.value =
                                "https://wa.me/+${controller.contactList[index].number ?? ""}'?text=${controller.textController.text}";
                            await launch(controller.url.value);
                            print("------${controller.url.value}");
                            print(
                                "contactsNumberList:-${controller.setContactsNumberList}");
                          },
                          child: const Icon(
                            Icons.whatsapp,
                            color: AppColor.appColors,
                          )),
                      title: GestureDetector(
                        onTap: () {
                          controller.numberController.text =
                              controller.contactList[index].number ?? "";
                        },
                        onLongPress: () async {
                          controller.textController.text =
                              controller.contactList[index].number ?? "";
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.darkBlue,
                              //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                              child: Text(
                                controller.contactList[index].name
                                            ?.isNotEmpty ??
                                        false
                                    ? controller.contactList[index].name
                                            ?.substring(0, 1) ??
                                        ""
                                    :
                                // controller
                                //             .contactListHistory[index].number
                                //             ?.substring(0, 3) ??
                                        "+91",
                                style: TextStyle(
                                  fontSize: controller.contactList[index]
                                              .name?.isNotEmpty ??
                                          false
                                      ? SizeUtils.horizontalBlockSize * 6
                                      : SizeUtils.horizontalBlockSize * 4,
                                  color: Colors.white,
                                  fontFamily: 'Customtext',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 3,
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 52,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.contactList[index].name
                                                ?.isNotEmpty ??
                                            false
                                        ? controller.contactList[index]
                                                .name ??
                                            ""
                                        : controller.contactList[index]
                                                .number ??
                                            "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Customtext',
                                      color: colorData(
                                        controller
                                            .contactList[index].callType,
                                      ),
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4.5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      iconData(
                                        controller
                                            .contactList[index].callType,
                                      ),
                                      Text(
                                        controller.formatMillisecondToDate(
                                          int.parse(
                                            controller.contactList[index]
                                                .timestamp
                                                .toString(),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: colorData(
                                            controller.contactList[index]
                                                .callType,
                                          ),
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 2,
                                right: SizeUtils.horizontalBlockSize * 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    makePhoneCall(
                                        contact:
                                            "${controller.contactList[index].number}",
                                        direct: true);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.call_outlined,
                                      ),
                                      Text(
                                        "Calls",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Customtext',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (Platform.isAndroid) {
                                      final uri =
                                          'sms:+${controller.contactList[index].number}}?body=${controller.textController.text}%20';
                                      // log("Sms :- $uri");
                                      await launch(uri);
                                    } else if (Platform.isIOS) {
                                      final uri =
                                          'sms:${controller.contactList[index].number}}&body=${controller.textController.text}%20';
                                      await launch(uri);
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.message,
                                      ),
                                      Text(
                                        "Messages",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Customtext',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.history,
                                        size: SizeUtils.horizontalBlockSize * 7,
                                      ),
                                      Text(
                                        "History",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Customtext',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: controller.contactList.length,
        ),
      ),
    );
  }

  Widget imageDetails({required IconData icons, required Color color}) {
    return SizedBox(
      width: SizeUtils.horizontalBlockSize * 5,
      child: Icon(
        icons,
        color: color,
        size: SizeUtils.horizontalBlockSize * 4,
      ),
    );
  }

  iconData(CallType? callType) {
    switch (callType) {
      case CallType.incoming:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_down_left, color: AppColor.appColors);
        }

      case CallType.outgoing:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_up_right, color: AppColor.appColors);
        }
      case CallType.rejected:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_up_right, color: AppColor.appColors);
        }
      case CallType.missed:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_90deg_up, color: Colors.red);
        }
      case CallType.wifiOutgoing:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_up_right, color: AppColor.appColors);
        }
      case CallType.wifiIncoming:
        {
          return imageDetails(
              icons: BootstrapIcons.wifi, color: AppColor.appColors);
        }
      case CallType.blocked:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_down_right_square_fill,
              color: AppColor.appColors);
        }
      default:
        {
          return imageDetails(
              icons: BootstrapIcons.arrow_up_right, color: AppColor.appColors);
        }
    }
  }

  colorData(CallType? callType) {
    switch (callType) {
      case CallType.missed:
        {
          return Colors.red;
        }
      default:
        {
          return Colors.black;
        }
    }
  }
}
