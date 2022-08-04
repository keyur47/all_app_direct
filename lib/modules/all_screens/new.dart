import 'dart:developer';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'history/all_history.dart';
import 'history/mycallhistory.dart';
import 'history/mycontactlist.dart';

class New  extends StatefulWidget {
   New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeUtils.horizontalBlockSize * 5,
            right: SizeUtils.horizontalBlockSize * 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
              border: Border.all(
                  width: 0.2, color: AppColor.grey.withOpacity(
                  0.3)),
              borderRadius: BorderRadius.circular(
                SizeUtils.horizontalBlockSize * 1,
              ),
              color: AppColor.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.horizontalBlockSize * 4,
                right: SizeUtils.horizontalBlockSize * 3,
                top: SizeUtils.horizontalBlockSize * 3,
                bottom: SizeUtils.horizontalBlockSize * 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Direct reply to",
                        style: TextStyle(
                            fontSize:
                            SizeUtils.horizontalBlockSize * 4.4,
                            color: AppColor.darkBlue,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 3,
                      ),

                      /// contacts
                      Obx(
                            () =>
                            GestureDetector(
                              onTap: () async {
                                controller
                                    .myContactListHistoryChekBox
                                    .value = false;
                                controller.myAllContactListChekBox
                                    .value = false;
                                controller
                                    .isError.value = false;
                                controller.myContactListChekBox
                                    .value =
                                !controller.myContactListChekBox
                                    .value;
                                // await controller.contactCallHistoryButtonClick();
                                fetchContacts();
                              },
                              child: Row(
                                children: [
                                  controller.myContactListChekBox
                                      .value
                                      ? const Icon(
                                    Icons.radio_button_checked,
                                    color: AppColor.appColors,
                                  )
                                      : const Icon(
                                      Icons
                                          .radio_button_unchecked_sharp,
                                      color: AppColor.appColors),
                                  SizedBox(
                                    width:
                                    SizeUtils
                                        .horizontalBlockSize * 1,
                                  ),
                                  Text(
                                    StringsUtils.contactList,
                                    style: TextStyle(
                                        color: controller
                                            .myContactListChekBox
                                            .value
                                            ? AppColor.darkBlue
                                            .withOpacity(0.6)
                                            : AppColor.grey,
                                        fontSize:
                                        SizeUtils
                                            .horizontalBlockSize *
                                            4),
                                  ),
                                ],
                              ),
                            ),
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 2,
                      ),

                      /// history
                      Obx(
                            () =>
                            GestureDetector(
                              onTap: () async {
                                controller
                                    .isError.value = false;
                                await callHistoryButtonClick();
                                controller.myContactListChekBox
                                    .value =
                                false;
                                controller.myAllContactListChekBox
                                    .value = false;
                                controller
                                    .myContactListHistoryChekBox
                                    .value =
                                !controller
                                    .myContactListHistoryChekBox
                                    .value;
                              },
                              child: Row(
                                children: [
                                  controller
                                      .myContactListHistoryChekBox
                                      .value
                                      ? const Icon(
                                    Icons.radio_button_checked,
                                    color: AppColor.appColors,
                                  )
                                      : const Icon(
                                      Icons
                                          .radio_button_unchecked_sharp,
                                      color: AppColor.appColors),
                                  SizedBox(
                                    width:
                                    SizeUtils
                                        .horizontalBlockSize * 1,
                                  ),
                                  Text(
                                    StringsUtils.callHistoryList,
                                    style: TextStyle(
                                        color: controller
                                            .myContactListHistoryChekBox
                                            .value
                                            ? AppColor.darkBlue
                                            .withOpacity(0.6)
                                            : AppColor.grey,
                                        fontSize:
                                        SizeUtils
                                            .horizontalBlockSize *
                                            4),
                                  ),
                                ],
                              ),
                            ),
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 2,
                      ),

                      /// all data
                      Obx(() =>
                          GestureDetector(
                            onTap: () async {
                              controller
                                  .isError.value = false;
                              controller.myContactListChekBox
                                  .value =
                              false;
                              controller
                                  .myContactListHistoryChekBox
                                  .value = false;
                              controller.myAllContactListChekBox
                                  .value =
                              !controller.myAllContactListChekBox
                                  .value;
                            },
                            child: Row(
                              children: [
                                controller
                                    .myAllContactListChekBox.value
                                    ? const Icon(
                                  Icons.radio_button_checked,
                                  color: AppColor.appColors,
                                )
                                    : const Icon(
                                    Icons
                                        .radio_button_unchecked_sharp,
                                    color: AppColor.appColors),
                                SizedBox(
                                  width:
                                  SizeUtils.horizontalBlockSize *
                                      1,
                                ),
                                Text(
                                  StringsUtils.allHistoryList,
                                  style: TextStyle(
                                      color: controller
                                          .myAllContactListChekBox
                                          .value
                                          ? AppColor.darkBlue
                                          .withOpacity(0.6)
                                          : AppColor.grey,
                                      fontSize:
                                      SizeUtils
                                          .horizontalBlockSize *
                                          4),
                                ),
                              ],
                            ),
                          ),
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 2,
                      ),

                      ///everyone
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // showDialog(
                      //   barrierDismissible: true,
                      //   context: Get.context!,
                      //   builder: (context) {
                      //     return Dialog(
                      //       backgroundColor: AppColor.white,
                      //       child: CheckBoxData(context),
                      //     );
                      //   },
                      // );
                    },
                    child: Icon(
                      Icons.info_outline,
                      size: SizeUtils.horizontalBlockSize * 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: SizeUtils.verticalBlockSize * 1,
        ),
        Obx(
              () => controller.myContactListChekBox.value == true
              ? MyContactList()
              : SizedBox(),
        ),
        Obx(
              () => controller.myContactListHistoryChekBox.value == true
              ? MyCallHistory()
              : SizedBox(),
        ),
        Obx(
              () => controller.myAllContactListChekBox.value == true
              ? AllHistory()
              : SizedBox(),
        ),
        SizedBox(
          height: SizeUtils.verticalBlockSize * 7,
        )
      ],
    );
  }

  callHistoryButtonClick() async {
    try {
      if (controller.contactListHistory.isEmpty) {
        await CallLog.get();
      }
    } catch (e) {
      await openAppSettings();
    }
    if (!controller.isContactsShowDialPad.value) {
      if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        if (controller.contactListHistory.isEmpty) {
          await getContact();
        }
      }
    }
    controller.isContactsShowDialPad.value =
    !controller.isContactsShowDialPad.value;
    controller.isContactsShowCallHistory.value =
    !controller.isContactsShowCallHistory.value;
  }

  Future<void> getContact() async {
    try {
      controller.contactListHistory.clear();
      var entries = await CallLog.get();
      for (var element in entries) {
        if (controller.contactListHistory.length < 100 &&
            controller.contactListHistory.indexWhere(
                    (elementInner) => elementInner.name == element.name) ==
                -1) {
          controller.contactListHistory.add(element);
        }
      }
    } catch (e, st) {
      log("e : $e , st $st");
    }
    setState(() {});
  }

   Future fetchContacts() async {
     if (!await FlutterContacts.requestPermission(readonly: true)) {
       setState(() {
         controller.permissionDenied = true.obs;
       });
     } else {
       final _contacts = await FlutterContacts.getContacts(withPhoto: true,withProperties: true);
       setState(() {
         controller.contacts = _contacts.obs;
       });
     }
   }
}
