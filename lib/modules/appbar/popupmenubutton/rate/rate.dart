import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Future RateBox(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    // barrierLabel: MaterialLocalizations.of(context)
    //     .modalBarrierDismissLabel,
    // barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(5),
          child: CupertinoAlertDialog(
            title: Column(
              children: [
                Icon(Icons.whatsapp,
                    size: 16,
                    color: AppColor.appColors,
                    shadows: [
                      BoxShadow(
                        color: AppColor.appColors.withOpacity(0.8),
                        spreadRadius: 10,
                        blurRadius: 7,
                        offset: const Offset(
                            2, 1),
                      ),
                    ]),
                SizedBox(
                  height: 1,
                ),
                Text(
                  StringsUtils.feedBackTitle,
                  style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Customtext"),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  StringsUtils.feedBackMessages,
                  style: TextStyle(fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: AppColor.grey,fontFamily: "Customtext"),
                ),
                SizedBox(
                  height: 1,
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                  onPressed: () {
                    Get.back();
                  } ,
                  child: Text(StringsUtils.feedBackButtonNotNow,
                    style: TextStyle(color: AppColor.green,fontFamily: "Customtext"),)),
            ],
            content: Center(
              child: RatingBar.builder(
                initialRating: 1.5,
                minRating: 1,
                itemSize: 2.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
          ),
        );
      },
  );
}
