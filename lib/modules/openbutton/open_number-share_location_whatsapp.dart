
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenShareLocationWhatsAppNumber extends StatelessWidget {
  OpenShareLocationWhatsAppNumber({Key? key}) : super(key: key);

  AllScreenController controller = Get.find();
  AdController adController = Get.find();

  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
           await adController.createRewardedAd();
          await getPermission();
          var permission =
          await Permission.location.status.isGranted;
          if (!permission) {
            await openAppSettings();
          }
          if (await Geolocator.isLocationServiceEnabled()) {
            Position? position;
            position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation,
              timeLimit: const Duration(seconds: 5),
            );

            var urls =
            "https://www.google.com/maps/?q=${position.latitude},${position.longitude}"
                .toString();
            final url = "See my location on Maps: $urls";
            final redirectUrl =
                "https://wa.me/${controller.numberController.text}?text=${Uri.parse("See my location on Maps \nhttp//www.google.com/maps/?q=${position.latitude},${position.longitude}")}";
            controller.onOpenWhatsApp(redirectUrl, url);
          }
        },
        text: StringsUtils.shareLocation,
        iconData: Icons.location_on_outlined,
        scale: SizeUtils.horizontalBlockSize* 8,
        top: SizeUtils.horizontalBlockSize*  2.2,
        left: SizeUtils.horizontalBlockSize* 2,
        right: SizeUtils.horizontalBlockSize* 1,
        bottom: SizeUtils.horizontalBlockSize* 2.2,
        ImageColor: AppColor.green,
        boxColor: AppColor.white,
        iconColor: AppColor.appColors,
        sizeIcon: SizeUtils.horizontalBlockSize*  7);
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
