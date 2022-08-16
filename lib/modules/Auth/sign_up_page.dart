import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_up_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:all_app_direct/widgets/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController signUpController = Get.find();
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
            Obx(
              () => Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ValueListenableBuilder(
                            valueListenable: _test,
                            builder: (context, bool value, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: height * .2),
                                  _title(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (_test.value
                                                      ? signUpController
                                                          .signUpEmail.text
                                                          .isValidEmail()
                                                      : signUpController
                                                          .signUpPassword.text
                                                          .isValidPassword()) {
                                                    await signUpController
                                                        .registerUsingEmailPassword(
                                                      name: signUpController
                                                          .signUpName.text,
                                                      contact: signUpController
                                                          .signUpContactNo.text,
                                                      email: signUpController
                                                          .signUpEmail.text
                                                          .trim(),
                                                      password: signUpController
                                                          .signUpPassword.text
                                                          .trim(),
                                                    );
                                                  }
                                                },
                                                change: value);
                                          }),
                                      // SizedBox(height: height * .14),
                                      _loginAccountLabel(),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      );
                    }),
                  ),
                  signUpController.signUpLoading.value
                      ? lottie()
                      : const SizedBox(),
                ],
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
    isDisable.value = (signUpController.signUpName.text == "" ||
            signUpController.signUpName.text.isEmpty) ||
        (signUpController.signUpEmail.text == "" ||
            signUpController.signUpEmail.text.isEmpty) ||
        (signUpController.signUpPassword.text == "" ||
            signUpController.signUpPassword.text.isEmpty);
  }

  /// _submitButton
  Widget _submitButton({
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
            : AppColor.darkBlue.withOpacity(0.4)
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
                  : AppColor.grey.withOpacity(0.5),
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: change
          ? Text(
              StringsUtils.register,
              style: TextStyle(fontSize: 20, color: AppColor.white),
            )
          : GestureDetector(
              onTap: onTap,
              child: Text(
                StringsUtils.register,
                style: TextStyle(
                    fontSize: 20,
                    color: themeController.isSwitched.value
                        ? AppColor.grey
                        : AppColor.white),
              ),
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
            'Already have an account ?',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.grey),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigation.popAndPushNamed(Routes.loginPage);
            },
            child: Text(
              'Sign In',
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

  ///_title
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Sign',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: themeController.isSwitched.value
                  ? AppColor.white
                  : AppColor.darkBlue),
          children: [
            TextSpan(
              text: ' Up',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,
                  fontSize: 30),
            ),
            TextSpan(
              text: '',
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
        _entryField("Name address", (String data) {
          _handleButtonDisable();
        }, "Enter your name", signUpController.signUpName),
        _entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", signUpController.signUpEmail),
        // _entryField(
        //   "Contacts no.",
        //   (String data) {
        //     _handleButtonDisable();
        //   },
        //   "Enter your Contacts",
        //   signUpController.signUpContactNo,
        //   isPassword: true,
        // ),
        _entryField("Password", (String data) {
          _handleButtonDisable();
        }, "Enter password", signUpController.signUpPassword),
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
            child: TextFormField(
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
}
