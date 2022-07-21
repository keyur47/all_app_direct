import 'package:all_app_direct/Utils/my_behavior.dart';
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child!,
              );
            },
            theme: ThemeData(
              fontFamily: "Customtext",
                colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.red)),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            getPages: Routes.routes,
            initialBinding: AppBidding(),
          );
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put(Controller());
    Get.put(AdController());
  }
}