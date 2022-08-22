import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/Auth/controller/forget_password_controller.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/Clipper/bezierContainer.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  ForgetPasswordController forgetPasswordController = Get.find();

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
      duration: forgetPasswordController.kLoginAnimationDuration,
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
                          return submitButton(
                              animation: _headerTextAnimation,
                              text: StringsUtils.confirm,
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
            Positioned(
                top: 40,
                left: 0,
                child: backButton(
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
    isDisable.value =
        (forgetPasswordController.forgetPasswordEmail.text == "" ||
            forgetPasswordController.forgetPasswordEmail.text.isEmpty);
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
        entryField("Email address", (String data) {
          _handleButtonDisable();
        }, "Enter your email", forgetPasswordController.forgetPasswordEmail,
            _headerTextAnimation),
      ],
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
              Navigation.pushNamed(Routes.loginPage);
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
}
