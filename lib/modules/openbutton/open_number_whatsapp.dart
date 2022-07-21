
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/toast_helper.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OpenWhatsAppNumber extends StatelessWidget {
  Controller controller = Get.find();
  AdController adController = Get.find();
  @override
  Widget build(BuildContext context) {
    return button(
      onTap: () async {
        await adController.createRewardedAd();
        await getPermission();
        if (controller.numberController.text != "") {
          print("numberController");
          controller.onOpenWhatsApp(controller.numberController.text,controller.textController.text);
          print("numberController11${controller.numberController.text}");
        } else {
          AppToast.toastMessage("Enter Mobile Number");
        }
      },
      text: StringsUtils.openWhatsApp,
      // iconData: Icons.whatsapp,
      //image: "assets/image/whatsapp.png",
      iconData: Icons.whatsapp,
      scale: SizeUtils.horizontalBlockSize* 3,
      top: SizeUtils.horizontalBlockSize*  2,
      left: SizeUtils.horizontalBlockSize* 2,
      right: SizeUtils.horizontalBlockSize* 1,
      bottom: SizeUtils.horizontalBlockSize* 2,
      ImageColor: AppColor.green,
      textColor: AppColor.black,
      boxColor: AppColor.white,
      iconColor:AppColor.appColors,
      // iconColor: Color(0xFF28D146),
      sizeIcon: SizeUtils.horizontalBlockSize* 7,
    );
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




// onTap: () async {
//   if (controller.numberController.text.isNotEmpty) {
//     // if (controller.countryNumber.isNotEmpty) {
//       await adController.createInterstitialAd();
//       ///
//       controller.contactsNumberList.addAll([controller.phoneController.text]);
//       await SharedPrefs.setNumberList(controller.contactsNumberList);
//       print("contactsNumberList:-${controller.contactsNumberList}");
//       ///
//       controller.countryNumberList.addAll([controller.countryNumber.value]);
//       await SharedPrefs.setCountryNumberList(controller.countryNumberList);
//       print("countryNumber:-${controller.countryNumberList}");
//       ///
//       controller.countryNameList.addAll([controller.countryName.value]);
//       await SharedPrefs.setCountryNameList(controller.countryNameList);
//       print("countryNameList:-${controller.countryNameList}");
//       ///
//       controller.dateTime.addAll([dateTime()]);
//       await SharedPrefs.setDateTimeList(controller.dateTime);
//       print("dateTime:-${controller.dateTime}");
//       ///
//       controller.day.addAll([day()]);
//       await SharedPrefs.setDayList(controller.day);
//       print("day:-${controller.day}");
//       ///
//       controller.type.addAll(["WhatsApp"]);
//       await SharedPrefs.setTypeList(controller.type);
//       print("Type:-${controller.type}");
//       ///
//       controller.chatContactsNumberList.addAll([controller.contactsNumberTextController.text]);
//       await SharedPrefs.setChatList(controller.chatContactsNumberList);
//       print("chat:-${controller.chatContactsNumberList}");
      ///
//        controller.url.value = "https://wa.me/+${controller.numberController.text}?text=${controller.textController.text}";
//        await launch(controller.url.value);
//        print("------${controller.url.value}");
//     } else {
//       AppSnackBar.showErrorSnackBar(
//         Icon: Icon(Icons.whatsapp, color: Colors.green, shadows: [
//           BoxShadow(
//             color: AppColor.appColors.withOpacity(0.8),
//             spreadRadius: 10,
//             blurRadius: 7,
//             offset: const Offset(2, 1), // changes position of shadow
//           ),
//         ]),
//         message: StringsUtils.pleaseCountryCode,
//         title: StringsUtils.openWhatsApp,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   //}
//   // else {
//   //   AppSnackBar.showErrorSnackBar(
//   //     Icon: Icon(Icons.whatsapp, color: Colors.green),
//   //     message: StringsUtils.pleasePhoneNumber,
//   //     title: StringsUtils.openWhatsApp,
//   //     snackPosition: SnackPosition.BOTTOM,
//   //   );
//   // }
// },