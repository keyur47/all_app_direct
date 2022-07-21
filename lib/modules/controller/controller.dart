import 'dart:io';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/widgets/toast_helper.dart';
import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
class Controller extends GetxController{

  TextEditingController snapchatUsernameController = TextEditingController();
  RxList<CallLogEntry> contactList = <CallLogEntry>[].obs;
  static ScrollController scrollController = ScrollController();
  TextEditingController numberController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController instagramUsernameController = TextEditingController();
  TextEditingController telegramUsernameController = TextEditingController();
  TextEditingController emailFeedBackController = TextEditingController();
  TextEditingController FeedBackController = TextEditingController();
  RxString url = ''.obs;
  RxString countryCode = "".obs;
  List<String> contactsNumberList = [];
  RxBool isShowDialPad = false.obs;
  RxBool isShowCallHistory = true.obs;
  RxBool collpan = false.obs;
  RxBool chekBox = false.obs;
  RxString errorMessage = "".obs;
  FocusNode emailFocusNode = FocusNode();
  FocusNode feedBackFocusNode = FocusNode();


  static void scrollUp() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 3), curve: Curves.easeInToLinear);
  }

  String getCountryNumber() {
    /// more than 10  digits and start with 00 remove 00 only
    String mobileNumber = numberController.text;

    if (mobileNumber.startsWith("+")) {
      print("+++++++++++++${mobileNumber.substring(1)}");
      return mobileNumber.substring(1);
    }

    if (mobileNumber.startsWith("00")) {
      print("000000000000-00${mobileNumber.substring(2)}");
      return mobileNumber.substring(2);
    }

    if (mobileNumber.startsWith("0")) {
      print("00000000000-0${countryCode.value + mobileNumber.substring(1)}");
      return countryCode.value + mobileNumber.substring(1);
    }

    if (!mobileNumber.startsWith(countryCode)) {
      return countryCode.value + mobileNumber;
    }
    print("mobileNumber------$mobileNumber");
    print("country code------$countryCode");
    return mobileNumber;
  }

  void onOpenWhatsApp(String countryCode, String message) async {
    if (numberController.text != "") {
      contactsNumberList.addAll([numberController.text]);
      await SharedPrefs.setNumberList(contactsNumberList);
      if (kDebugMode) {
        print("contactsNumberList:-$contactsNumberList");
      }
      try {
        if (Platform.isIOS) {
          String mobileNumber = getCountryNumber();
          print("Mobile Number $mobileNumber");
          var redirectUrl = "https://faq.whatsapp.com/$mobileNumber/?helpref=uf_share";
          // var redirectUrl =
          // "https://wa.me/$mobileNumber?text=${Uri.parse(message.replaceAll(":", ""))}";
          if (kDebugMode) {
            print("redirectUrl$redirectUrl");
          }
          if (await canLaunch(redirectUrl)) {
            await launch(redirectUrl, forceSafariVC: false);
          }
        } else {
          String mobileNumber = getCountryNumber();
          print("Mobile Number $mobileNumber");
          var redirectUrl =
              "https://wa.me/$mobileNumber?text=${Uri.parse(message.replaceAll(":", ""))}";
          if (kDebugMode) {
            print("redirectUrl$redirectUrl");
          }
          if (await canLaunch(redirectUrl)) {
            await launch(redirectUrl, forceSafariVC: false);
          }
          // await FlutterLaunch.launchWhatsapp(
          //     phone: getCountryNumber(), message: message);
        }
      } catch (e) {
        AppToast.toastMessage("Invalid Mobile Number");
      }
    } else {
      AppToast.toastMessage("Enter Mobile Number");
    }
  }

  String formatMillisecondToDate(int milliSecond) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliSecond);
    String formattedDate = DateFormat('h:mm a').format(date).toString();
    // String formattedDate = DateFormat('d/M/yy h:mm a').format(date).toString();
    String dateTime = "";
    if (formattedDate.contains(DateFormat('d/M/yy').format(DateTime.now()))) {
      dateTime = DateFormat('h:mm a').format(date).toString();
    } else {
      dateTime = DateFormat('h:mm a').format(date).toString();
      //dateTime = DateFormat('d/M/yy h:mm a').format(date).toString();
    }
    return dateTime;
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      errorMessage.value = StringsUtils.pleaseEmails;
    } else if (!EmailValidator.validate(val, true)) {
      errorMessage.value = "Invalid Email Address";
    } else {
      errorMessage.value = "";
    }
  }

}