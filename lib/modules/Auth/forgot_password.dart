import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/forget_password_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  ForgetPasswordController forgetPasswordController = Get.find();
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  final ValueNotifier<bool> _test = ValueNotifier(true);
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor(context),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .3),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                        valueListenable: isDisable,
                        builder: (context, bool value, _) {
                          return _submitButton(
                              context: context,
                              onTap: () {
                                forgetPasswordController.resetPassword(
                                    email: forgetPasswordController
                                        .forgetPasswordEmail.text
                                        .trim());
                              },
                              change: value);
                        }),
                    // SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  /// _handleButtonDisable
  void _handleButtonDisable() {
    isDisable.value =
        (forgetPasswordController.forgetPasswordEmail.text == "" ||
            forgetPasswordController.forgetPasswordEmail.text.isEmpty);
  }

  /// _submitButton
  Widget _submitButton({
    required context,
    required GestureTapCallback? onTap,
    bool change = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: change
            ? themeController.isSwitched.value
                ? AppColor.grey[200]
                : AppColor.grey[90]
            : themeController.isSwitched.value
                ? AppColor.white
                : AppColor.darkBlue,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: change
                  ? themeController.isSwitched.value
                      ? AppColor.black
                      : AppColor.backgroundColor
                  : themeController.isSwitched.value
                      ? AppColor.black
                      : AppColor.backgroundColor,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: change
          ? Text(
              StringsUtils.confirm,
              style: TextStyle(fontSize: 20, color: AppColor.white),
            )
          : GestureDetector(
              onTap: onTap,
              child: Text(
                StringsUtils.confirm,
                style: TextStyle(
                    fontSize: 20,
                    color: themeController.isSwitched.value
                        ? AppColor.grey
                        : AppColor.white),
              ),
            ),
    );
  }

  ///_title
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Verify',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: themeController.isSwitched.value
                  ? AppColor.white
                  : AppColor.darkBlue),
          children: [
            TextSpan(
              text: ' Your',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,
                  fontSize: 30),
            ),
            TextSpan(
              text: ' Email',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,
                  fontSize: 30),
            ),
          ]),
    );
  }

  ///_emailPasswordWidget
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", forgetPasswordController.forgetPasswordEmail),
      ],
    );
  }

  /// _entryField
  Widget _entryField(String title, ValueChanged<String>? onChanged, hinText,
      TextEditingController? TextEditingController,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: themeController.isSwitched.value
                  ? AppColor.white
                  : AppColor.darkBlue,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: themeController.isSwitched.value
                      ? AppColor.black
                      : AppColor.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: TextField(
                controller: TextEditingController,
                obscureText: isPassword,
                onChanged: onChanged,
                style: TextStyle(
                    color: themeController.isSwitched.value
                        ? AppColor.white
                        : AppColor.grey),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 15),
                    border: InputBorder.none,
                    hintText: hinText,
                    hintStyle: TextStyle(
                        color: themeController.isSwitched.value
                            ? AppColor.white
                            : AppColor.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.red, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                      // borderSide: BorderSide.none
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: themeController.isSwitched.value
                        ? AppColor.grey[200]
                        : AppColor.white,
                    filled: true)),
          )
        ],
      ),
    );
  }

  ///_loginAccountLabel
  Widget _loginAccountLabel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            '',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigation.popAndPushNamed(Routes.loginPage);
            },
            child: Text(
              'Back to login',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// _backButton
  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        Navigation.popAndPushNamed(Routes.loginPage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left,
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
