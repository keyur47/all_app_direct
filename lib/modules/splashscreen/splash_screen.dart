import 'dart:async';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  final List<Color> _kDefaultRainbowColors = const [
    AppColor.darkBlue,
  ];
  @override
  void initState() {
    super.initState();
    try {
      startTimeOut();
    } catch (e) {
      // AppException.showException(e);
    }
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 2),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/image/splash_logo.png",width: SizeUtils.horizontalBlockSize * 35,),
                  const Text(
                    StringsUtils.whatsAppDirect,
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: "Customtext",
                        color: AppColor.darkBlue,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 5),
            child: SizedBox(
              height: SizeUtils.horizontalBlockSize * 10,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: _kDefaultRainbowColors,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startTimeOut(){
    _timer = Timer.periodic(
      const Duration(seconds: 2),
          (timer) {
        Get.offAllNamed(Routes.whatsapp);
      },
    );
  }
}
