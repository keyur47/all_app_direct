import 'package:all_app_direct/ads/banner_ad.dart';
import 'package:all_app_direct/ads/open_ad.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/all_history_button.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/messages_textformfield.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/phone_number_textformfield.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/modules/openbutton/open_call.dart';
import 'package:all_app_direct/modules/openbutton/open_number-share_location_whatsapp.dart';
import 'package:all_app_direct/modules/openbutton/open_number_whatsapp.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhatsApp extends StatefulWidget {
  WhatsApp({Key? key}) : super(key: key);

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> with WidgetsBindingObserver{
  AllScreenController controller = Get.find();
  ThemeController themeController = Get.find();

  late AppLifecycleReactor _appLifecycleReactor;
  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    print("r");
  }



  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColor.backgroundColorScreen,
              content: const Text(
                'Are you sure want to exit?',
                style: TextStyle(color: AppColor.darkBlue),
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.darkBlue)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child:
                      const Text('NO', style: TextStyle(color: AppColor.white)),
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.darkBlue)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('YES',
                      style: TextStyle(color: AppColor.white)),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor:ColorRes.backgroundColor(context),
          resizeToAvoidBottomInset: false,
          // bottomSheet: BannerAds(),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  customAppbar(
                    text: StringsUtils.whatsDirects,
                    icon: Icons.whatsapp,
                    top: SizeUtils.horizontalBlockSize * 0.7,
                    bottom: SizeUtils.horizontalBlockSize * 1.1,
                    right: SizeUtils.horizontalBlockSize * 1.1,
                    left: SizeUtils.horizontalBlockSize * 1.1,
                    size: SizeUtils.horizontalBlockSize * 11,
                    directText: StringsUtils.whatsDirects,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 4,
                        vertical: SizeUtils.verticalBlockSize * 2),
                    child: Column(
                      children: [
                        PhoneNumberTextFormField(),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1,
                        ),
                        Obx(
                          () => Container(
                            height: controller.messageSizeButton.value
                                ? SizeUtils.horizontalBlockSize * 36
                                : SizeUtils.horizontalBlockSize * 13.5,
                            decoration: BoxDecoration(
                              boxShadow:  const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                controller.messageSizeButton.value
                                    ? SizeUtils.horizontalBlockSize * 5
                                    : SizeUtils.horizontalBlockSize * 10,
                              ),
                              color:  themeController.isSwitched.value ?AppColor.grey[200] :AppColor.white,
                            ),
                            child: MessagesTextFormField(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 4,
                        ),
                        OpenCalls(),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3.5,
                        ),
                        OpenWhatsAppNumber(),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3.5,
                        ),
                        OpenShareLocationWhatsAppNumber(),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 4,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: AllHistoryButton())
                ],
              ),
              BannerAds()
            ],
          ),
          floatingActionButton: Padding(
            padding:  EdgeInsets.only(bottom: SizeUtils.verticalBlockSize * 8),
            child: Obx(
              () => controller.myAppCallHistoryChekBox.value == true || controller.myPhoneContactListChekBox.value == true
                  ? FloatingActionButton(
                   elevation: 0,
                   backgroundColor: themeController.isSwitched.value ? AppColor.grey[200]:AppColor.darkBlue,
                      child: const Icon(Icons.arrow_upward_rounded),
                      onPressed: () async {
                        controller.myPhoneCallListChekBox.value == true
                            ?  AllScreenController.myAppScrollUp()
                            : AllScreenController.contactScrollUp();
                      },
                    )
                  : const SizedBox(),
            ),
          ),
        ),

    );
  }

  Widget CheckBoxData(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeUtils.verticalBlockSize * 2.5,
              horizontal: SizeUtils.horizontalBlockSize * 4),
          child: Column(
            children: [
              Text.rich(TextSpan(
                  text: StringsUtils.list2,
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.fSize_15()),
                  children: <InlineSpan>[
                    TextSpan(
                      text: StringsUtils.list1,
                      style: TextStyle(
                          color: AppColor.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeUtils.fSize_13()),
                    )
                  ])),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 2,
              ),
              Text.rich(TextSpan(
                  text: StringsUtils.list3,
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.fSize_15()),
                  children: <InlineSpan>[
                    TextSpan(
                      text: StringsUtils.list4,
                      style: TextStyle(
                          color: AppColor.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeUtils.fSize_13()),
                    )
                  ])),
            ],
          ),
        ),
      ],
    );
  }
}













/// callHistoryButtonClick
// callHistoryButtonClick() async {
//   try {
//     if (controller.contactListHistory.isEmpty) {
//       await CallLog.get();
//     }
//   } catch (e) {
//     await openAppSettings();
//   }
//   if (!controller.isContactsShowDialPad.value) {
//     if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
//       await openAppSettings();
//     } else {
//       if (controller.contactListHistory.isEmpty) {
//         await getContact();
//       }
//     }
//   }
//   controller.isContactsShowDialPad.value =
//       !controller.isContactsShowDialPad.value;
//   controller.isContactsShowCallHistory.value =
//       !controller.isContactsShowCallHistory.value;
// }
//
// Future<void> getContact() async {
//   try {
//     controller.contactListHistory.clear();
//     var entries = await CallLog.get();
//     for (var element in entries) {
//       if (controller.contactListHistory.length < 100 &&
//           controller.contactListHistory.indexWhere(
//                   (elementInner) => elementInner.name == element.name) ==
//               -1) {
//         controller.contactListHistory.add(element);
//       }
//     }
//   } catch (e, st) {
//     log("e : $e , st $st");
//   }
//   setState(() {});
// }

// Future fetchContacts() async {
//   if (!await FlutterContacts.requestPermission(readonly: true)) {
//     setState(() {
//       controller.permissionDenied = true.obs;
//     });
//   } else {
//     final _contacts = await FlutterContacts.getContacts();
//     setState(() {
//       controller.contacts = _contacts.obs;
//     });
//   }
// }


/// buttons code
// Padding(
//   padding: EdgeInsets.only(
//     left: SizeUtils.horizontalBlockSize * 5,
//     right: SizeUtils.horizontalBlockSize * 5,
//   ),
//   child: Container(
//     decoration: BoxDecoration(
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 4,
//           offset: Offset(4, 8), // Shadow position
//         ),
//       ],
//       border: Border.all(
//           width: 0.2, color: AppColor.grey.withOpacity(
//           0.3)),
//       borderRadius: BorderRadius.circular(
//         SizeUtils.horizontalBlockSize * 1,
//       ),
//       color: AppColor.white,
//     ),
//     child: Padding(
//       padding: EdgeInsets.only(
//         left: SizeUtils.horizontalBlockSize * 4,
//         right: SizeUtils.horizontalBlockSize * 3,
//         top: SizeUtils.horizontalBlockSize * 3,
//         bottom: SizeUtils.horizontalBlockSize * 1,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Direct reply to",
//                 style: TextStyle(
//                     fontSize:
//                     SizeUtils.horizontalBlockSize * 4.4,
//                     color: AppColor.darkBlue,
//                     fontWeight: FontWeight.w700),
//               ),
//               SizedBox(
//                 height: SizeUtils.horizontalBlockSize * 3,
//               ),
//
//               /// contacts
//               Obx(
//                     () =>
//                     GestureDetector(
//                       onTap: () async {
//                         controller
//                             .myContactListHistoryChekBox
//                             .value = false;
//                         controller.myAllContactListChekBox
//                             .value = false;
//                         controller
//                             .isError.value = false;
//                         controller.myContactListChekBox
//                             .value =
//                         !controller.myContactListChekBox
//                             .value;
//                         // await controller.contactCallHistoryButtonClick();
//                         fetchContacts();
//                       },
//                       child: Row(
//                         children: [
//                           controller.myContactListChekBox
//                               .value
//                               ? const Icon(
//                             Icons.radio_button_checked,
//                             color: AppColor.appColors,
//                           )
//                               : const Icon(
//                               Icons
//                                   .radio_button_unchecked_sharp,
//                               color: AppColor.appColors),
//                           SizedBox(
//                             width:
//                             SizeUtils
//                                 .horizontalBlockSize * 1,
//                           ),
//                           Text(
//                             StringsUtils.contactList,
//                             style: TextStyle(
//                                 color: controller
//                                     .myContactListChekBox
//                                     .value
//                                     ? AppColor.darkBlue
//                                     .withOpacity(0.6)
//                                     : AppColor.grey,
//                                 fontSize:
//                                 SizeUtils
//                                     .horizontalBlockSize *
//                                     4),
//                           ),
//                         ],
//                       ),
//                     ),
//               ),
//               SizedBox(
//                 height: SizeUtils.horizontalBlockSize * 2,
//               ),
//
//               /// history
//               Obx(
//                     () =>
//                     GestureDetector(
//                       onTap: () async {
//                         controller
//                             .isError.value = false;
//                         await callHistoryButtonClick();
//                         controller.myContactListChekBox
//                             .value =
//                         false;
//                         controller.myAllContactListChekBox
//                             .value = false;
//                         controller
//                             .myContactListHistoryChekBox
//                             .value =
//                         !controller
//                             .myContactListHistoryChekBox
//                             .value;
//                       },
//                       child: Row(
//                         children: [
//                           controller
//                               .myContactListHistoryChekBox
//                               .value
//                               ? const Icon(
//                             Icons.radio_button_checked,
//                             color: AppColor.appColors,
//                           )
//                               : const Icon(
//                               Icons
//                                   .radio_button_unchecked_sharp,
//                               color: AppColor.appColors),
//                           SizedBox(
//                             width:
//                             SizeUtils
//                                 .horizontalBlockSize * 1,
//                           ),
//                           Text(
//                             StringsUtils.callHistoryList,
//                             style: TextStyle(
//                                 color: controller
//                                     .myContactListHistoryChekBox
//                                     .value
//                                     ? AppColor.darkBlue
//                                     .withOpacity(0.6)
//                                     : AppColor.grey,
//                                 fontSize:
//                                 SizeUtils
//                                     .horizontalBlockSize *
//                                     4),
//                           ),
//                         ],
//                       ),
//                     ),
//               ),
//               SizedBox(
//                 height: SizeUtils.horizontalBlockSize * 2,
//               ),
//
//               /// all data
//               Obx(() =>
//                   GestureDetector(
//                     onTap: () async {
//                       controller
//                           .isError.value = false;
//                       controller.myContactListChekBox
//                           .value =
//                       false;
//                       controller
//                           .myContactListHistoryChekBox
//                           .value = false;
//                       controller.myAllContactListChekBox
//                           .value =
//                       !controller.myAllContactListChekBox
//                           .value;
//                     },
//                     child: Row(
//                       children: [
//                         controller
//                             .myAllContactListChekBox.value
//                             ? const Icon(
//                           Icons.radio_button_checked,
//                           color: AppColor.appColors,
//                         )
//                             : const Icon(
//                             Icons
//                                 .radio_button_unchecked_sharp,
//                             color: AppColor.appColors),
//                         SizedBox(
//                           width:
//                           SizeUtils.horizontalBlockSize *
//                               1,
//                         ),
//                         Text(
//                           StringsUtils.allHistoryList,
//                           style: TextStyle(
//                               color: controller
//                                   .myAllContactListChekBox
//                                   .value
//                                   ? AppColor.darkBlue
//                                   .withOpacity(0.6)
//                                   : AppColor.grey,
//                               fontSize:
//                               SizeUtils
//                                   .horizontalBlockSize *
//                                   4),
//                         ),
//                       ],
//                     ),
//                   ),
//               ),
//               SizedBox(
//                 height: SizeUtils.horizontalBlockSize * 2,
//               ),
//
//               ///everyone
//             ],
//           ),
//           GestureDetector(
//             onTap: () {
//               showDialog(
//                 barrierDismissible: true,
//                 context: Get.context!,
//                 builder: (context) {
//                   return Dialog(
//                     backgroundColor: AppColor.white,
//                     child: CheckBoxData(context),
//                   );
//                 },
//               );
//             },
//             child: Icon(
//               Icons.info_outline,
//               size: SizeUtils.horizontalBlockSize * 6,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
// SizedBox(
//   height: SizeUtils.verticalBlockSize * 1,
// ),
// Obx(
//   () => controller.myContactListChekBox.value == true
//       ? Expanded(
//           child: MyContactList(),
//         )
//       : SizedBox(),
// ),
// Obx(
//   () => controller.myContactListHistoryChekBox.value == true
//       ? Expanded(
//           child: MyCallHistory(),
//         )
//       : SizedBox(),
// ),
// Obx(
//   () => controller.myAllContactListChekBox.value == true
//       ? Expanded(
//           child: AllHistory(),
//         )
//       : SizedBox(),
// ),
// SizedBox(
//   height: SizeUtils.verticalBlockSize * 7,
// )