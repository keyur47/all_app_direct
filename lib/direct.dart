import 'package:all_app_direct/Utils/my_behavior.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/widgets/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Direct extends StatelessWidget {
  Direct({Key? key}) : super(key: key);
  ThemeController _themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return Scaffold(
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: _themeController.setTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Routes.routes,
      initialBinding: AppBinding(),
    );
  }
}
