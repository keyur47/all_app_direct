import 'dart:developer';

import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_in_controller.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/facebook_login/facebook_login.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/gmail_login/gmail_login.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:all_app_direct/widgets/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LogInController logInController = Get.find();
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
          backgroundColor: ColorRes.backgroundColor(context),
          body: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
                Stack(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 50),
                                        _emailPasswordWidget(),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 3, bottom: 5),
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigation.popAndPushNamed(
                                                  Routes.forgotPassword);
                                            },
                                            child: Text('Forgot Password ?',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: themeController
                                                            .isSwitched.value
                                                        ? AppColor.white
                                                        : AppColor
                                                            .darkBlue[200])),
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        ValueListenableBuilder(
                                            valueListenable: isDisable,
                                            builder: (context, bool value, _) {
                                              return _submitButton(
                                                  onTap: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if (_test.value
                                                        ? logInController
                                                            .logInEmail.text
                                                            .isValidEmail()
                                                        : logInController
                                                            .logInPassword.text
                                                            .isValidPassword()) {
                                                      await logInController
                                                          .signInUsingEmailPassword(
                                                              email:
                                                                  logInController
                                                                      .logInEmail
                                                                      .text
                                                                      .trim(),
                                                              password:
                                                                  logInController
                                                                      .logInPassword
                                                                      .text
                                                                      .trim());
                                                    }
                                                    print(
                                                        "emailcontroller---------${logInController.logInEmail.text}");
                                                    print(
                                                        "passwordController---------${logInController.logInPassword.text}");
                                                  },
                                                  change: value);
                                            }),
                                        _createAccountLabel(),
                                        _divider(),
                                        _auto_login_G_F_M(),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        );
                      }),
                    ),
                    logInController.logInLoading.value ||
                            logInController.gmailLoading.value ||
                            logInController.facebookLoading.value
                        ? lottie()
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  /// _handleButtonDisable
  void _handleButtonDisable() {
    isDisable.value = (logInController.logInEmail.text == "" ||
            logInController.logInEmail.text.isEmpty) ||
        (logInController.logInPassword.text == "" ||
            logInController.logInPassword.text.isEmpty);
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
        color: change
            ? themeController.isSwitched.value
                ? AppColor.grey[200]
            : AppColor.darkBlue.withOpacity(0.4)
            : themeController.isSwitched.value
                ? AppColor.white
                : AppColor.darkBlue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: change
                  ? themeController.isSwitched.value
                      ? AppColor.black
                      : AppColor.backgroundColor
                  : themeController.isSwitched.value
                      ? AppColor.black
                      : AppColor.backgroundColor,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      // colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: change
          ? Text(
              StringsUtils.signIn,
              style: TextStyle(fontSize: 20, color: AppColor.white),
            )
          : GestureDetector(
              onTap: onTap,
              child: Text(
                StringsUtils.signIn,
                style: TextStyle(
                    fontSize: 20,
                    color: themeController.isSwitched.value
                        ? AppColor.grey
                        : AppColor.white),
              ),
            ),
    );
  }

  /// _createAccountLabel
  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(
                fontSize: 13,
                color: themeController.isSwitched.value
                    ? AppColor.grey
                    : AppColor.grey,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigation.popAndPushNamed(Routes.signUpPage);
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue[200],
                  // color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// _title
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
              text: ' In',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,
                  fontSize: 30),
            ),
            TextSpan(
              text: '',
              style: TextStyle(color: AppColor.darkBlue, fontSize: 30),
            ),
          ]),
    );
  }

  /// _emailPasswordWidget
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", logInController.logInEmail),
        Obx(()=>
           _entryField(
            "Password",
            (String data) {
              _handleButtonDisable();
            },
            "Enter password",
            isPassword: logInController.isObscure.value,
            logInController.logInPassword,
            suffixIcon: Obx(()=>
              GestureDetector(
                onTap: () {
                  logInController
                      .isObscure.value =
                  !logInController
                      .isObscure.value;
                  log("${logInController.isObscure.value}");
                },
                child: logInController
                    .isObscure.value
                    ? const Icon(
                  Icons
                      .remove_red_eye_outlined,
                  color: Colors.grey,
                )
                    : const Icon(
                  Icons
                      .remove_red_eye,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// _entryField
  Widget _entryField(String title, ValueChanged<String>? onChanged,
      String hinText, TextEditingController TextEditingController,
      {bool isPassword = false,Widget? suffixIcon,}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                    : AppColor.darkBlue),
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
                  suffixIcon: suffixIcon,
                    hintText: hinText,
                    hintStyle: TextStyle(
                        color: themeController.isSwitched.value
                            ? AppColor.white
                            : AppColor.grey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 15),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColor.red, width: 1.5),
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

  /// _auto_login_G_F_M
  Widget _auto_login_G_F_M() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                FirebaseService service = FirebaseService();
                await service.signInWithGoogle();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(AppColor.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              child: SvgPicture.asset(AssetsPath.google),
            ),
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Get.toNamed(Routes
                //     .mobileScreen);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(AppColor.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              child: const Icon(
                Icons.phone_android,
                color: AppColor.black,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                signInWithFacebook();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(AppColor.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsPath.faceBook),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// _divider
  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: AppColor.grey.withOpacity(0.4),
              ),
            ),
          ),
          Text(
            'Or login with',
            style: TextStyle(color: AppColor.black),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: AppColor.grey.withOpacity(0.4),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

/// _backButton
// Widget _backButton() {
//   return InkWell(
//     onTap: () {
//       Navigator.pop(context);
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
//             child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
//           ),
//           const Text('Back',
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//         ],
//       ),
//     ),
//   );
// }

// / _divider
// Widget _divider() {
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 10),
//     child: Row(
//       children: const <Widget>[
//         SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Divider(
//               thickness: 1,
//             ),
//           ),
//         ),
//         Text('or'),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Divider(
//               thickness: 1,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//       ],
//     ),
//   );
// }
//
// / _facebookButton
// Widget _facebookButton() {
//   return Container(
//     height: 50,
//     margin: const EdgeInsets.symmetric(vertical: 20),
//     decoration: const BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         // Image.network(
//         //     "https://cdn4.iconfinder.com/data/icons/social-messaging-ui-color-shapes-2/128/social-circle-google-plus-2-512.png",
//         //     height: 35),
//         // SizedBox(width: 10,),
//         // Image.asset("assets/image/facebook-logo-png-2320.png", height: 33),
//
//         // Expanded(
//         //   flex: 1,
//         //   child: Container(
//         //     decoration: const BoxDecoration(
//         //       color: Color(0xff1959a9),
//         //       borderRadius: BorderRadius.only(
//         //           bottomLeft: Radius.circular(5),
//         //           topLeft: Radius.circular(5)),
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: const Text('f',
//         //         style: TextStyle(
//         //             color: Colors.white,
//         //             fontSize: 25,
//         //             fontWeight: FontWeight.w400)),
//         //   ),
//         // ),
//         // Expanded(
//         //   flex: 5,
//         //   child: Container(
//         //     decoration: const BoxDecoration(
//         //       color: Color(0xff2872ba),
//         //       borderRadius: BorderRadius.only(
//         //           bottomRight: Radius.circular(5),
//         //           topRight: Radius.circular(5)),
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: const Text('Log in with Facebook',
//         //         style: TextStyle(
//         //             color: Colors.white,
//         //             fontSize: 18,
//         //             fontWeight: FontWeight.w400)),
//         //   ),
//         // ),
//       ],
//     ),
//   );
// }
