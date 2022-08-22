

import 'package:all_app_direct/modules/Auth/forgot_password.dart';
import 'package:all_app_direct/modules/Auth/sign_in_page.dart';
import 'package:all_app_direct/modules/Auth/sign_up_page.dart';
import 'package:all_app_direct/modules/all_screens/gallery/gallery.dart';
import 'package:all_app_direct/modules/all_screens/instagram/instagram.dart';
import 'package:all_app_direct/modules/all_screens/snapchat/snapchat.dart';
import 'package:all_app_direct/modules/all_screens/telegram/telegram.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/whatsapp.dart';
import 'package:all_app_direct/modules/onboarding/onboarding_Screen.dart';
import 'package:all_app_direct/modules/splashscreen/splash_screen.dart';
import 'package:all_app_direct/utils/onbording/screen/onboarding.dart';
import 'package:get/get.dart';


mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash_screen';
  static const String onboardingScreen = '/onBoardingScreen';
  static const String loginPage = '/LoginPage';
  static const String signUpPage = '/SignUpPage';
  static const String forgotPassword = '/ForgotPassword';
  static const homePage = '/homePage_screen';
  static const whatsapp = '/whatsapp_screen';
  static const instagram = '/instagram_screen';
  static const telegram = '/telegram_screen';
  static const snapchat = '/snapchat_screen';
  static const galleryFileImage = '/galleryFileImage';
  static List<GetPage<dynamic>> routes = [
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: onboardingScreen,
      page: () => Onboarding(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: loginPage,
      page: () => LoginPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signUpPage,
      page: () => SignUpPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: forgotPassword,
      page: () => ForgotPassword(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: whatsapp,
      page: () => WhatsApp(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: instagram,
      page: () => Instagram(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: telegram,
      page: () => Telegram(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: snapchat,
      page: () => Snapchat(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: galleryFileImage,
      page: () => GalleryFileImage(),
      transition: defaultTransition,
    ),
  ];
}
