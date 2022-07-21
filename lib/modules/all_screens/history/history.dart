import 'dart:developer';
import 'dart:io';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  static const routeName = '/contact_screen';

  Contact({Key? key}) : super(key: key);
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).copyWith(dividerColor: Colors.transparent); //new
    return RawScrollbar(
      crossAxisMargin: SizeUtils.horizontalBlockSize * 1,
      controller: Controller.scrollController,
      interactive: false,
      thickness: 3,
      thumbColor: Colors.transparent,
      radius: const Radius.circular(12),
      child: ListView.builder(
        controller: Controller.scrollController,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                left: SizeUtils.horizontalBlockSize * 3,
                right: SizeUtils.horizontalBlockSize * 3),
            child: Column(
              children: [
                SwipeActionCell(
                  backgroundColor: Colors.transparent,
                  key: ObjectKey(
                    controller.contactList[index],
                  ),
                  trailingActions: const <SwipeAction>[],
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(width: 1),
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Theme(
                        data: theme,
                        child: ExpansionTile(
                          trailing: GestureDetector(
                              onTap: () async {
                                controller.url.value =
                                    "https://wa.me/+${controller.contactList[index].number ?? ""}'?text=${controller.textController.text}";
                                await launch(controller.url.value);
                                print("------${controller.url.value}");
                                controller.contactsNumberList.addAll([
                                  (controller.contactList[index].number ?? "")
                                ]);
                                await SharedPrefs.setNumberList(
                                    controller.contactsNumberList);
                                print(
                                    "contactsNumberList:-${controller.contactsNumberList}");
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: SizeUtils.horizontalBlockSize * 2.8,
                                ),
                                child: const Icon(
                                  Icons.whatsapp,
                                  color: AppColor.appColors,
                                ),
                              )),
                          title: GestureDetector(
                            onTap: () {
                              controller.numberController.text =
                                  controller.contactList[index].number ?? "";
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColor.darkBlue,
                                  // Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                  child: Text(
                                    controller.contactList[index].name
                                                ?.isNotEmpty ??
                                            false
                                        ? controller.contactList[index].name
                                                ?.substring(0, 1) ??
                                            ""
                                        : controller.contactList[index].number
                                                ?.substring(0, 3) ??
                                            "",
                                    style: TextStyle(
                                      fontSize: controller.contactList[index]
                                                  .name?.isNotEmpty ??
                                              false
                                          ? SizeUtils.horizontalBlockSize * 6
                                          : SizeUtils.horizontalBlockSize * 5,
                                      color: Colors.white,
                                      fontFamily: 'Customtext',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 3,
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 56,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.contactList[index].name
                                                    ?.isNotEmpty ??
                                                false
                                            ? controller
                                                    .contactList[index].name ??
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
                                              SizeUtils.horizontalBlockSize * 5,
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
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          log("Sms :- $uri");
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
                                        children: const [
                                          Icon(
                                            Icons.history,
                                            size: 7,
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
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 1,
                )
              ],
            ),
          );
        },
        itemCount: controller.contactList.length,
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
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }

      case CallType.outgoing:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }
      case CallType.rejected:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }
      case CallType.missed:
        {
          return imageDetails(icons: Icons.call, color: Colors.red);
        }
      case CallType.wifiOutgoing:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }
      case CallType.wifiIncoming:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }
      case CallType.blocked:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
        }
      default:
        {
          return imageDetails(icons: Icons.call, color: AppColor.appColors);
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
