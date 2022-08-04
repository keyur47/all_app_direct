import 'dart:async';
import 'package:all_app_direct/model/demo.dart';
import 'package:all_app_direct/modules/login/Widget/bezierContainer.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late Timer _timer;
  final List<Color> _kDefaultRainbowColors = const [
    AppColor.darkBlue,
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   try {
  //     startTimeOut();
  //   } catch (e) {
  //     // AppException.showException(e);
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   if (_timer.isActive) {
  //     _timer.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    SizeUtils().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Positioned(
          //     top: -height * .15,
          //     right: -MediaQuery.of(context).size.width * .4,
          //     child: const BezierContainer()),
          Padding(
            padding:  EdgeInsets.only(bottom: SizeUtils.horizontalBlockSize * 2),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsPath.splashScreenAppLogo,width: SizeUtils.horizontalBlockSize * 35,),
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

  // void startTimeOut(){
  //   _timer = Timer.periodic(
  //     const Duration(seconds: 2),
  //         (timer) {
  //       // Get.to(MyHomePage());
  //       Get.offAllNamed(Routes.whatsapp);
  //     },
  //   );
  // }
}
