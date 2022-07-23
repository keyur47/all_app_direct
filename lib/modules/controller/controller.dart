import 'dart:developer';
import 'dart:io';
import 'package:all_app_direct/modules/all_screens/history/mycallhistory.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/widgets/toast_helper.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
class AllScreenController extends GetxController{

  TextEditingController snapchatUsernameController = TextEditingController();
  RxList<CallLogEntry> contactListHistory = <CallLogEntry>[].obs;
  static ScrollController myCallScrollController = ScrollController();
  static ScrollController myContactScrollController = ScrollController();
  TextEditingController numberController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController instagramUsernameController = TextEditingController();
  TextEditingController telegramUsernameController = TextEditingController();
  TextEditingController emailFeedBackController = TextEditingController();
  TextEditingController FeedBackController = TextEditingController();
  RxString url = ''.obs;
  RxString countryCode = "".obs;
  List<String> contactsNumberList = [];
  RxBool isContactsShowDialPad = false.obs;
  RxBool isContactsShowCallHistory = true.obs;
  RxBool collpan = false.obs;
  RxBool myContactListHistoryChekBox = false.obs;
  RxBool myContactListChekBox = false.obs;
  RxString errorMessage = "".obs;
  FocusNode emailFocusNode = FocusNode();
  FocusNode feedBackFocusNode = FocusNode();
  ///contact List
  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;
  RxString photo = ''.obs;



  static void CallScrollUp() {
    myCallScrollController.animateTo(myCallScrollController.position.minScrollExtent,
        duration: const Duration(seconds: 3), curve: Curves.easeInToLinear);
  }

  static void contactScrollUp() {
    myContactScrollController.animateTo(myContactScrollController.position.minScrollExtent,
        duration: const Duration(seconds: 3), curve: Curves.easeInToLinear);
  }

  String getCountryNumberHistory() {
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
          String mobileNumber = getCountryNumberHistory();
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
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          var redirectUrl =
              "https://wa.me/$mobileNumber?text=${Uri.parse(message.replaceAll(":", ""))}";
          if (kDebugMode) {
            print("redirectUrl$redirectUrl");
          }
          if (await canLaunch(redirectUrl)) {
            await launch(redirectUrl, forceSafariVC: false);
          }
        }
      } catch (e) {
        AppToast.toastMessage("Invalid Mobile Number");
      }
    } else {
      AppToast.toastMessage("Enter Mobile Number");
    }
  }
  void onOpenCalls(String countryCode) async {
    if (numberController.text != "") {
      contactsNumberList.addAll([numberController.text]);
      await SharedPrefs.setNumberList(contactsNumberList);
      if (kDebugMode) {
        print("contactsNumberList:-$contactsNumberList");
      }
      try {
        if (Platform.isIOS) {
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          makePhoneCall(
              contact:
              "$mobileNumber",
              direct: true);
        } else {
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          makePhoneCall(
              contact:
              "$mobileNumber",
              direct: true);
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

  contactCallHistoryButtonClick() async {
    try {
      if (contactListHistory.isEmpty) {
        await CallLog.get();
      }
    } catch (e) {
      // print("getContactHistory1333");
      await openAppSettings();
    }
    if (!isContactsShowDialPad.value) {
      if (await Permission.phone.status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        if (contactListHistory.isEmpty) {
          await getContactHistory();
        }
      }
    }
   isContactsShowDialPad.value = !isContactsShowDialPad.value;
   isContactsShowCallHistory.value = !isContactsShowCallHistory.value;
  }

  Future<void> getContactHistory() async {
    try {
     contactListHistory.clear();
      var entries = await CallLog.get();
      for (var element in entries) {
        if (contactListHistory.length < 100 &&
           contactListHistory.indexWhere(
                    (elementInner) => elementInner.name == element.name) ==
                -1) {
        contactListHistory.add(element);
        }
      }
      // print("getContactHistory");
    } catch (e, st) {
      // print("getContactHistory12");
      log("error: $e , st $st");
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
    countryCode.value = country.phoneCode;
  }
}