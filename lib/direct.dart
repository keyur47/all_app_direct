import 'package:all_app_direct/Utils/my_behavior.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/widgets/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class Direct extends StatelessWidget {
  Direct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
      theme: ThemeData(
          fontFamily: AssetsPath.roboto,
          colorScheme:
          Theme.of(context).colorScheme.copyWith(secondary: Colors.red)),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Routes.routes,
      initialBinding: AppBinding(),
    );
  }
}
