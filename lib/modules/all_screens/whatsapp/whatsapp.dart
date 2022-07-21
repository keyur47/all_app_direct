import 'dart:developer';
import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/modules/all_screens/history/history.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/messages_textformfield.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/phone_number_textformfield.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/open_number-share_location_whatsapp.dart';
import 'package:all_app_direct/modules/openbutton/open_number_whatsapp.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:call_log/call_log.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class WhatsApp extends StatelessWidget {
   WhatsApp({Key? key}) : super(key: key);
Controller controller = Get.find();
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
            Container(
              child: Column(
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
                    top: SizeUtils.horizontalBlockSize *0.7,
                    bottom: SizeUtils.horizontalBlockSize *0.8,
                    right: SizeUtils.horizontalBlockSize *1.1,
                    left: SizeUtils.horizontalBlockSize *1.1,
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
                              child: PhoneNumberTextFormField()
                          ),
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1,
                        ),
                        Obx(
                              () => Container(
                            height: controller.collpan.value ? SizeUtils.horizontalBlockSize * 36 :SizeUtils.horizontalBlockSize * 14,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OpenWhatsAppNumber(),
                         SizedBox(
                          width: SizeUtils.horizontalBlockSize* 3.5,
                        ),
                        OpenShareLocationWhatsAppNumber(),
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
                    child: Row(
                      children: [
                        Obx(
                              () => GestureDetector(
                              onTap: () {
                                controller.chekBox.value =
                                !controller.chekBox.value;
                                callHistoryButtonClick();
                              },
                              child: controller.chekBox.value
                                  ? const Icon(Icons.check_box,color: AppColor.darkBlue,)
                                  : const Icon(Icons.check_box_outline_blank,color: AppColor.darkBlue)),
                        ),
                        const Text(" Contacts History"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 2,
                  ),
                  Obx(
                        () => controller.chekBox.value == true
                        ? Expanded(
                      child: Contact(),
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            Container(
              child: const BannerAds(),
            ),
          ],
        ),
        floatingActionButton: Obx(
              () => controller.chekBox.value == true
              ? FloatingActionButton(
            backgroundColor: AppColor.darkBlue,
            child: const Icon(Icons.arrow_upward_rounded),
            onPressed: () {
              Controller.scrollUp();
            },
          )
              : const SizedBox(),
        ),
      ),

    );
  }


  callHistoryButtonClick() async {
    try {
      if (controller.contactList.isEmpty) {
        await CallLog.get();
      }
    } catch (e) {
      await openAppSettings();
    }
    if (!controller.isShowDialPad.value) {
      if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        if (controller.contactList.isEmpty) {
          await getContact();
        }
      }
    }
    controller.isShowDialPad.value = !controller.isShowDialPad.value;
    controller.isShowCallHistory.value = !controller.isShowCallHistory.value;
  }

  Future<void> getContact() async {
    try {
      controller.contactList.clear();
      var entries = await CallLog.get();
      for (var element in entries) {
        if (controller.contactList.length < 100 &&
            controller.contactList.indexWhere(
                    (elementInner) => elementInner.name == element.name) ==
                -1) {
          controller.contactList.add(element);
        }
      }
    } catch (e, st) {
      log("e : $e , st $st");
    }
    // setState(() {});
  }

  Future<void> getPermission() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    var country = CountryPickerUtils.getCountryByName(
        coordinates.first.country.toString());
    controller.countryCode.value = country.phoneCode;
  }
}
