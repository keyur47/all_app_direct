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
  AllScreenController _homePageController = Get.find();

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
                                _homePageController
                                    .myContactListHistoryChekBox
                                    .value = false;
                                _homePageController.myAllContactListChekBox
                                    .value = false;
                                _homePageController
                                    .isError.value = false;
                                _homePageController.myContactListChekBox
                                    .value =
                                !_homePageController.myContactListChekBox
                                    .value;
                                // await controller.contactCallHistoryButtonClick();
                                fetchContacts();
                              },
                              child: Row(
                                children: [
                                  _homePageController.myContactListChekBox
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
                                        color: _homePageController
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
                                _homePageController
                                    .isError.value = false;
                                try {
                                  print("callHistoryButtonClick error :- 1123");
                                  callHistoryButtonClick();
                                } catch (e,st) {
                                 print("callHistoryButtonClick error :- $e $st");
                                }

                                _homePageController.myContactListChekBox
                                    .value =
                                false;
                                _homePageController.myAllContactListChekBox
                                    .value = false;
                                _homePageController
                                    .myContactListHistoryChekBox
                                    .value =
                                !_homePageController
                                    .myContactListHistoryChekBox
                                    .value;
                              },
                              child: Row(
                                children: [
                                  _homePageController
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
                                        color: _homePageController
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
                              _homePageController
                                  .isError.value = false;
                              _homePageController.myContactListChekBox
                                  .value =
                              false;
                              _homePageController
                                  .myContactListHistoryChekBox
                                  .value = false;
                              _homePageController.myAllContactListChekBox
                                  .value =
                              !_homePageController.myAllContactListChekBox
                                  .value;
                            },
                            child: Row(
                              children: [
                                _homePageController
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
                                      color: _homePageController
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
              () => _homePageController.myContactListChekBox.value == true
              ? MyContactList()
              : SizedBox(),
        ),
        Obx(
              () => _homePageController.myContactListHistoryChekBox.value == true
              ? MyCallHistory()
              : SizedBox(),
        ),
        Obx(
              () => _homePageController.myAllContactListChekBox.value == true
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
      print("callHistoryButtonClick-1");
      if (_homePageController.contactList.isEmpty) {
        print("callHistoryButtonClick-2");
        await CallLog.get();
        print("callHistoryButtonClick-3");
      }
      print("callHistoryButtonClick-4");
    } catch (e) {
      print("callHistoryButtonClick-5");
      await openAppSettings();
      print("callHistoryButtonClick-6");
    }
    if (!_homePageController.isShowDialPad.value) {
      if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        if (_homePageController.contactList.isEmpty) {
          await getContact();
        }
      }
    }
    _homePageController.isShowDialPad.value =
    !_homePageController.isShowDialPad.value;
    _homePageController.isShowCallHistory.value =
    !_homePageController.isShowCallHistory.value;
  }

  Future<void> getContact() async {
    try {
      _homePageController.contactList.clear();
      var entries = await CallLog.get();
      for (var element in entries) {
        if (_homePageController.contactList.length < 100 &&
            _homePageController.contactList.indexWhere(
                    (elementInner) => elementInner.name == element.name) ==
                -1) {
          _homePageController.contactList.add(element);
        }
      }
    } catch (e, st) {
      log("e : $e , st $st");
    }
    setState(() {});
  }

  // callHistoryButtonClick() async {
  //   try {
  //     print("callHistoryButtonClick-1");
  //     if (controller.contactListHistory.isEmpty) {
  //       print("callHistoryButtonClick-2");
  //       await CallLog.get();
  //       print("callHistoryButtonClick-3");
  //     }
  //     print("callHistoryButtonClick-4");
  //   } catch (e) {
  //     print("callHistoryButtonClick-5");
  //     await openAppSettings();
  //     print("callHistoryButtonClick-6");
  //   }
  //   if (!controller.isContactsShowDialPad.value) {
  //     print("callHistoryButtonClick-7");
  //     if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
  //       print("callHistoryButtonClick-8");
  //       await openAppSettings();
  //       print("callHistoryButtonClick-9");
  //     } else {
  //       print("callHistoryButtonClick-10");
  //       if (controller.contactListHistory.isEmpty) {
  //         print("callHistoryButtonClick-11");
  //         await getContact();
  //         print("callHistoryButtonClick-12");
  //       }
  //       print("callHistoryButtonClick-13");
  //     }
  //     print("callHistoryButtonClick-14");
  //   }
  //   print("callHistoryButtonClick-15");
  //   controller.isContactsShowDialPad.value = !controller.isContactsShowDialPad.value;
  //   print("callHistoryButtonClick-16");
  //   controller.isContactsShowCallHistory.value = !controller.isContactsShowCallHistory.value;
  //   print("callHistoryButtonClick-17");
  // }
  //
  // Future<void> getContact() async {
  //   try {
  //     print("callHistoryButtonClick-18");
  //     controller.contactListHistory.clear();
  //     print("callHistoryButtonClick-19");
  //     var entries = await CallLog.get();
  //     print("callHistoryButtonClick-20");
  //     for (var element in entries) {
  //       print("callHistoryButtonClick-21");
  //       if (controller.contactListHistory.length < 100 && controller.contactListHistory.indexWhere((elementInner) => elementInner.name == element.name) == -1) {
  //         print("callHistoryButtonClick-22");
  //         controller.contactListHistory.add(element);
  //         print("callHistoryButtonClick-23");
  //       }
  //       print("callHistoryButtonClick-24");
  //     }
  //     print("callHistoryButtonClick-25");
  //   } catch (e, st) {
  //     print("callHistoryButtonClick-26");
  //     log("e : $e , st $st");
  //     print("callHistoryButtonClick-27");
  //   }
  //   print("callHistoryButtonClick-28");
  //   setState(() {
  //     print("callHistoryButtonClick-29");
  //   });
  //   print("callHistoryButtonClick-30");
  // }

   Future fetchContacts() async {
     if (!await FlutterContacts.requestPermission(readonly: true)) {
       setState(() {
         _homePageController.permissionDenied = true.obs;
       });
     } else {
       final _contacts = await FlutterContacts.getContacts(withPhoto: true,withProperties: true);
       setState(() {
         _homePageController.contacts = _contacts.obs;
       });
     }
   }

}
