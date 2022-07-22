import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/modules/all_screens/history/history.dart';
import 'package:all_app_direct/modules/all_screens/history/list.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/messages_textformfield.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/phone_number_textformfield.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/open_call.dart';
import 'package:all_app_direct/modules/openbutton/open_number-share_location_whatsapp.dart';
import 'package:all_app_direct/modules/openbutton/open_number_whatsapp.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class WhatsApp extends StatefulWidget {
  WhatsApp({Key? key}) : super(key: key);

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> {
  AllScreenController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    // callHistoryButtonClick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColor.backgroundColor,
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
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                customAppbar(
                  text: StringsUtils.whatsDirects,
                  icon: Icons.whatsapp,
                  iconColor: AppColor.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        // Color(0xFF5FFC7B),
                        // Color(0xFF28D146),
                        AppColor.darkBlue,
                        AppColor.darkBlue,
                      ]),
                  top: SizeUtils.horizontalBlockSize * 0.7,
                  bottom: SizeUtils.horizontalBlockSize * 0.8,
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
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            SizeUtils.horizontalBlockSize * 10,
                          ),
                          color: AppColor.white,
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeUtils.horizontalBlockSize * 4,
                            ),
                            child: PhoneNumberTextFormField()),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      Obx(
                        () => Container(
                          height: controller.collpan.value
                              ? SizeUtils.horizontalBlockSize * 36
                              : SizeUtils.horizontalBlockSize * 14,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              controller.collpan.value
                                  ? SizeUtils.horizontalBlockSize * 5
                                  : SizeUtils.horizontalBlockSize * 10,
                            ),
                            color: AppColor.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeUtils.horizontalBlockSize * 4,
                            ),
                            child: MessagesTextFormField(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OpenWhatsAppNumber(),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 3.5,
                          ),
                          OpenShareLocationWhatsAppNumber(),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 5,
                      ),
                      OpenCalls()
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeUtils.horizontalBlockSize * 5,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                                onTap: () async {
                                  controller.myContactListChekBox.value =
                                      !controller.myContactListChekBox.value;
                                  controller.contactCallHistoryButtonClick();
                                  fetchContacts();
                                },
                                child: controller.myContactListChekBox.value
                                    ? const Icon(
                                        Icons.check_box,
                                        color: AppColor.appColors,
                                      )
                                    : const Icon(Icons.check_box_outline_blank,
                                        color: AppColor.appColors)),
                          ),
                          SizedBox(width: SizeUtils.horizontalBlockSize * 2,),
                          Text(
                            StringsUtils.contactList,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: AppColor.darkBlue),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.horizontalBlockSize * 5,),
                      Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                                onTap: () async {
                                  controller.myContactListHistoryChekBox.value =
                                      !controller.myContactListHistoryChekBox.value;
                                  fetchContacts();
                                },
                                child: controller.myContactListHistoryChekBox.value
                                    ? const Icon(
                                        Icons.check_box,
                                        color: AppColor.appColors,
                                      )
                                    : const Icon(Icons.check_box_outline_blank,
                                        color: AppColor.appColors)),
                          ),
                          SizedBox(width: SizeUtils.horizontalBlockSize * 2,),
                          Text(
                            StringsUtils.callHistoryList,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: AppColor.darkBlue,fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                Obx(
                      () => controller.myContactListChekBox.value == true
                      ? Expanded(
                    child: ContactScreen(),
                  )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.myContactListHistoryChekBox.value == true
                      ? Expanded(
                          child: ListData(),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            const BannerAds(),
          ],
        ),
        floatingActionButton: Obx(
          () => controller.myContactListHistoryChekBox.value == true
              ? FloatingActionButton(
                  backgroundColor: AppColor.darkBlue,
                  child: const Icon(Icons.arrow_upward_rounded),
                  onPressed: () {
                    AllScreenController.scrollUp();
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() {
        controller.permissionDenied = true.obs;
      });
    } else {
      final _contacts = await FlutterContacts.getContacts();
      setState(() {
        controller.contacts = _contacts.obs;
      });
    }
  }
}
