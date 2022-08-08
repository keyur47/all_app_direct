import 'dart:io';

import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:call_log/call_log.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AllScreenController extends GetxController {
  RxList<CallLogEntry> contactList = <CallLogEntry>[].obs;
  static ScrollController myCallScrollController = ScrollController();
  static ScrollController myContactScrollController = ScrollController();
  TextEditingController numberController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController instagramUsernameController = TextEditingController();
  TextEditingController telegramUsernameController = TextEditingController();
  TextEditingController snapchatUsernameController = TextEditingController();
  TextEditingController emailFeedBackController = TextEditingController();
  TextEditingController FeedBackController = TextEditingController();
  RxString url = ''.obs;
  RxString countryCode = "".obs;
  RxList<String> setContactsNumberList = <String>[].obs;
  RxList<String> getContactsNumberList = <String>[].obs;
  RxList<String> setInstagramUsernameList = <String>[].obs;
  RxList<String> getInstagramUsernameList = <String>[].obs;
  RxList<String> setTelegramUsernameList = <String>[].obs;
  RxList<String> getTelegramUsernameList = <String>[].obs;
  RxList<String> setSnapchatUsernameList = <String>[].obs;
  RxList<String> getSnapchatUsernameList = <String>[].obs;
  RxList<String> newSnapchatUsernameList = <String>[].obs;
  RxBool isShowDialPad = false.obs;
  RxBool isShowCallHistory = true.obs;
  RxBool collpan = false.obs;
  RxBool myContactListHistoryChekBox = false.obs;
  RxBool myContactListChekBox = false.obs;
  RxBool myAllContactListChekBox = false.obs;
  RxBool collpan1 = false.obs;
  RxBool isError = true.obs;
  RxString errorMessage = "".obs;
  FocusNode emailFocusNode = FocusNode();
  FocusNode feedBackFocusNode = FocusNode();

  ///contact List
  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;
  RxString photo = ''.obs;
  RxBool boxSize = false.obs;

  @override
  void onInit() {
    super.onInit();
    getContactsNumberData();
    getInstagramData();
    getSnapchatData();
    getTelegramData();
  }

  ///  getContactsNumberData
  getContactsNumberData() async {
    setContactsNumberList.value = await SharedPrefs.getNumberList();
    getContactsNumberList.value = setContactsNumberList.toSet().toList();
    setContactsNumberList.join("");
    getContactsNumberList.join("");
  }

  ///  getInstagramData
  getInstagramData() async {
   setInstagramUsernameList.value = await SharedPrefs.getInstagramList();
   getInstagramUsernameList.value = setInstagramUsernameList.toSet().toList();
     setInstagramUsernameList.join("");
    getInstagramUsernameList.join("");
  }


  ///  getSnapchatData
  getSnapchatData() async {
    setSnapchatUsernameList.value = await SharedPrefs.getSnapchatList();
    getSnapchatUsernameList.value = setSnapchatUsernameList.toSet().toList();
    setSnapchatUsernameList.join("");
    getSnapchatUsernameList.join("");
  }

  ///  getTelegramData
  getTelegramData() async {
    setTelegramUsernameList.value = await SharedPrefs.getTelegramList();
    getTelegramUsernameList.value = setTelegramUsernameList.toSet().toList();
    setTelegramUsernameList.join("");
    getTelegramUsernameList.join("");
  }

  /// onOpenWhatsAppDialogBox
  void onOpenWhatsApp(String countryCode, String message) async {
    if (numberController.text != "") {
      if (kDebugMode) {
        print("contactsNumberList:-$setContactsNumberList");
      }
      try {
        if (Platform.isIOS) {
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          setContactsNumberList.addAll([(mobileNumber)]);
          await SharedPrefs.setNumberList(setContactsNumberList);
          var redirectUrl =
              "https://faq.whatsapp.com/$mobileNumber/?helpref=uf_share";
          getContactsNumberData();
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
          setContactsNumberList.addAll([(mobileNumber)]);
          await SharedPrefs.setNumberList(setContactsNumberList);
          var redirectUrl = "https://wa.me/$mobileNumber?text=${Uri.parse(message.replaceAll(":", ""))}";
          getContactsNumberData();
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

  /// getCountryNumberHistory
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

  /// onOpenCalls
  void onOpenCalls(String countryCode) async {
    if (numberController.text != "") {
      if (kDebugMode) {
        print("contactsNumberList:-$setContactsNumberList");
      }
      try {
        if (Platform.isIOS) {
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          makePhoneCall(contact: "$mobileNumber", direct: true);
        } else {
          String mobileNumber = getCountryNumberHistory();
          print("Mobile Number $mobileNumber");
          setContactsNumberList.addAll([(mobileNumber)]);
          await SharedPrefs.setNumberList(setContactsNumberList);
          makePhoneCall(contact: "$mobileNumber", direct: true);
        }
      } catch (e) {
        AppToast.toastMessage("Invalid Mobile Number");
      }
    } else {
      AppToast.toastMessage("Enter Mobile Number");
    }
  }

  ///  callScrollUp
  static void callScrollUp() {
    myCallScrollController.animateTo(
        myCallScrollController.position.minScrollExtent,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInToLinear);
  }

  /// contactScrollUp
  static void contactScrollUp() {
    myContactScrollController.animateTo(
        myContactScrollController.position.minScrollExtent,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInToLinear);
  }

  /// formatMillisecondToDate
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

  /// All getPermission
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

  /// validateEmail
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
