
// ignore_for_file: non_constant_identifier_names

import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


Widget button(
    {required String text,
    required VoidCallback onTap,
    IconData? iconData,
    required Color boxColor,
    Color? ImageColor,
    double? scale,
    required double left,
    required double right,
    required double top,
    required double bottom,
    Decoration? decoration,
    double? sizeIcon,
    required Color iconColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding:  EdgeInsets.only(bottom: SizeUtils.verticalBlockSize * 1.5),
      child: Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize* 10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
            // border: Border.all(width: 0.1)
        ),
        child:Padding(
          padding: EdgeInsets.only(
              left: left, right: right, top: top, bottom: bottom),
          child: Center(
            child: Row(
              children: [
                Container(
                        decoration: decoration,
                        child: Icon(iconData, color: iconColor, size: sizeIcon,)),
                const SizedBox(
                  width: 1,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: left, right: right, top: top, bottom: bottom),
                      child: Text(text,style: const TextStyle(color: Colors.transparent,fontSize: 14),),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                        height: 1,
                          fontSize: 14.0,
                          fontFamily: 'Customtext',
                          color: AppColor.darkBlue,fontWeight: FontWeight.w600),
                      child: AnimatedTextKit(
                        pause: const Duration(milliseconds: 100),
                        animatedTexts: [
                          TypewriterAnimatedText(text),
                        ],
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
