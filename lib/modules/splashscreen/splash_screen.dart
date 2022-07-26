import 'package:all_app_direct/ads/ads_new.dart';
import 'package:all_app_direct/ads/open_ad.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/assets_path.dart';
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



  ThemeController themeController = Get.find();

  final List<Color> _kDarkBlueDefaultRainbowColors = const [
    AppColor.darkBlue,
  ];
  final List<Color> _kWhiteDefaultRainbowColors = const [
    AppColor.white,
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
      backgroundColor: ColorRes.backgroundColor(context),
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
                  Image.asset(AssetsPath.splashScreenAppLogo,width: SizeUtils.horizontalBlockSize * 35,color: themeController.isSwitched.value
                      ? AppColor.white
                      : AppColor.darkBlue,),
                   Text(
                    StringsUtils.whatsAppDirect,
                    style: TextStyle(
                        fontSize: 26,
                        color:  themeController.isSwitched.value
                            ? AppColor.white
                            : AppColor.darkBlue,
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
                colors: themeController.isSwitched.value
                    ? _kWhiteDefaultRainbowColors
                    : _kDarkBlueDefaultRainbowColors,
                // colors: _kDefaultRainbowColors,
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
