import 'dart:io';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCallHistory extends StatelessWidget {

  MyCallHistory({Key? key}) : super(key: key);
  final AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).copyWith(dividerColor: Colors.transparent); //new
    return  Obx(()=>
       ListView.builder(
        controller: AllScreenController.myCallScrollController,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return
            Theme(
            data: theme,
            child: ExpansionTile(
              trailing: GestureDetector(
                  onTap: () async {
                    controller.url.value =
                        "https://wa.me/+${controller.contactListHistory[index].number ?? ""}'?text=${controller.textController.text}";
                    await launch(controller.url.value);
                    print("------${controller.url.value}");
                    // controller.contactsNumberList.addAll(
                    //     [(controller.contactListHistory[index].number ?? "")]);
                    // await SharedPrefs.setNumberList(
                    //     controller.contactsNumberList);
                    print("contactsNumberList:-${controller.setContactsNumberList}");
                  },
                  child: const Icon(
                    Icons.whatsapp,
                    color: AppColor.appColors,
                  )),
              title: GestureDetector(
                onTap: () {
                  controller.numberController.text =
                      controller.contactListHistory[index].number ?? "";
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                      AppColor.darkBlue,
                       //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                      child: Text(
                        controller.contactListHistory[index].name
                                    ?.isNotEmpty ??
                                false
                            ? controller.contactListHistory[index].name
                                    ?.substring(0, 1) ??
                                ""
                            : controller.contactListHistory[index].number
                                    ?.substring(0, 3) ??
                                "",
                        style: TextStyle(
                          fontSize: controller.contactListHistory[index].name
                                      ?.isNotEmpty ??
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
                            controller.contactListHistory[index].name
                                        ?.isNotEmpty ??
                                    false
                                ? controller.contactListHistory[index].name ??
                                    ""
                                : controller
                                        .contactListHistory[index].number ??
                                    "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Customtext',
                              color: colorData(
                                controller.contactListHistory[index].callType,
                              ),
                              fontSize:
                                  SizeUtils.horizontalBlockSize * 4.5,
                            ),
                          ),
                          Row(
                            children: [
                              iconData(
                                controller.contactListHistory[index].callType,
                              ),
                              Text(
                                controller.formatMillisecondToDate(
                                  int.parse(
                                    controller
                                        .contactListHistory[index].timestamp
                                        .toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  color: colorData(
                                    controller
                                        .contactListHistory[index].callType,
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
                                    "${controller.contactListHistory[index].number}",
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
                                  'sms:+${controller.contactListHistory[index].number}}?body=${controller.textController.text}%20';
                              // log("Sms :- $uri");
                              await launch(uri);
                            } else if (Platform.isIOS) {
                              final uri =
                                  'sms:${controller.contactListHistory[index].number}}&body=${controller.textController.text}%20';
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
          );
        },
        itemCount: controller.contactListHistory.length,
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
              icons: BootstrapIcons.wifi,color: AppColor.appColors);
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
