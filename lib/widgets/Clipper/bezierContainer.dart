import 'dart:math';

import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
   BezierContainer({Key ?key}) : super(key: key);
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi / 3.5, 
        child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height *.5,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
            color: themeController.isSwitched.value ? AppColor.grey[200] :AppColor.darkBlue,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   // colors: [Color(0xfffbb448),Color(0xffe46b10)]
              //   colors: [Color(0xFF000749),Color(0xFF000749)]
              // )
            ),
        ),
      ),
      )
    );
  }
}