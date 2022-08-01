import 'package:all_app_direct/modules/all_screens/gallery/gallery.dart';
import 'package:all_app_direct/modules/all_screens/instagram/instagram.dart';
import 'package:all_app_direct/modules/all_screens/snapchat/snapchat.dart';
import 'package:all_app_direct/modules/all_screens/telegram/telegram.dart';
import 'package:all_app_direct/modules/all_screens/whatsapp/whatsapp.dart';
import 'package:all_app_direct/modules/splash_1.dart';
import 'package:all_app_direct/modules/splash_2.dart';
import 'package:all_app_direct/modules/splash_3.dart';
import 'package:all_app_direct/modules/splashscreen/splash_screen.dart';
import 'package:get/get.dart';


mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash_screen';
  static const String splashBox1 = '/SplashBox1';
  static const String splashBox2 = '/SplashBox2';
  static const String splashBox3 = '/SplashBox3';
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
      name: splashBox1,
      page: () => SplashBox1(),
      transition: defaultTransition,
    ),
    // GetPage<dynamic>(
    //   name: splashBox2,
    //   page: () => SplashBox2(),
    //   transition: defaultTransition,
    // ),
    // GetPage<dynamic>(
    //   name: splashBox3,
    //   page: () => SplashBox3(),
    //   transition: defaultTransition,
    // ),
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
