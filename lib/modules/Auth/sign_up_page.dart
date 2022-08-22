import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/sign_up_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
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

class _SignUpPageState extends State<SignUpPage>  with SingleTickerProviderStateMixin{
  SignUpController signUpController = Get.find();
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  final ValueNotifier<bool> _test = ValueNotifier(true);
  ThemeController themeController = Get.find();
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _headerTextAnimation;
  late final AnimationController _animationController;
  // Duration kLoginAnimationDuration = Duration(milliseconds: 2000);

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: signUpController.kLoginAnimationDuration,
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
                                            return submitButton(
                                                animation: _headerTextAnimation,

                                                context: context,
                                              text: StringsUtils.register,
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
            Positioned(top: 40, left: 0, child: backButton(
                  () {
                Navigation.popAndPushNamed(Routes.loginPage);
              },
            )),
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

  /// _backButton

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
        entryField("Name address", (String data) {
          _handleButtonDisable();
        }, "Enter your name", signUpController.signUpName,_headerTextAnimation),
        entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", signUpController.signUpEmail,_headerTextAnimation),
        entryField("Password", (String data) {
          _handleButtonDisable();
        }, "Enter password", signUpController.signUpPassword,_headerTextAnimation),
      ],
    );
  }

}
