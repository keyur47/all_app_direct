import 'dart:developer';

import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_in_controller.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/facebook_login/facebook_login.dart';
import 'package:all_app_direct/modules/Auth/login_with_google_mobile_facebook/gmail_login/gmail_login.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:all_app_direct/widgets/fade_slide_transition.dart';
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

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  LogInController logInController = Get.find();
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  ThemeController themeController = Get.find();
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _headerTextAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: logInController.kLoginAnimationDuration,
    );
    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                                        _emailAndPasswordWidget(),
                                        FadeSlideTransition(
                                          animation: _headerTextAnimation,
                                          additionalOffset: 0.0,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 3, bottom: 5),
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigation.pushNamed(
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
                                        ),
                                        const SizedBox(height: 50),
                                        ValueListenableBuilder(
                                            valueListenable: isDisable,
                                            builder: (context, bool value, _) {
                                              return submitButton(
                                                animation: _headerTextAnimation,
                                                  context: context,
                                                  text: StringsUtils.signIn,
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
              Navigation.pushNamed(Routes.signUpPage);
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue[200],
                  // color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
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
  Widget _emailAndPasswordWidget() {
    return Column(
      children: <Widget>[
        entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", logInController.logInEmail,
            _headerTextAnimation),
        Obx(
          () => entryField("Password", (String data) {
            _handleButtonDisable();
          },
              "Enter password",
              obscure: logInController.isObscure.value,
              logInController.logInPassword,
              suffixIcon: Obx(
                () => GestureDetector(
                  onTap: () {
                    logInController.isObscure.value =
                        !logInController.isObscure.value;
                    log("${logInController.isObscure.value}");
                  },
                  child: logInController.isObscure.value
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility_rounded,
                          color: Colors.grey,
                        ),
                ),
              ),
              _headerTextAnimation),
        ),
      ],
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
            style: TextStyle(
                color: themeController.isSwitched.value
                    ? AppColor.white
                    : AppColor.black),
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
