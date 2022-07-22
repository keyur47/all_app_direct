import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reviews_slider/reviews_slider.dart';


AllScreenController controller = Get.find();

Future FeedbackBox(context) {
  return showModalBottomSheet(
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: 60,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5, left: 5, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textField(
                        focusNode: controller.emailFocusNode,
                        boxBorder: Border.all(
                          width: 2,color: AppColor.darkBlue
                        ),
                        controller: controller.emailFeedBackController,
                        hintText: StringsUtils.email,
                        textInputType: TextInputType.text,
                        maxLines: 1,
                        color: AppColor.backgroundColor,
                        textStyle: const TextStyle(color: AppColor.grey, fontSize: 14,fontFamily: "Customtext"),
                        style:
                            const TextStyle(fontSize: 16, color: AppColor.black),
                        cursorColor: Colors.black,
                        valueChanged: (val) {
                          controller.validateEmail(val);
                        }),
                    Obx(()=>
                       Text(
                        controller.errorMessage.value,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 1),
                child: textField(
                  boxBorder: Border.all(
                    width: 2,color: AppColor.darkBlue),
                  focusNode: controller.feedBackFocusNode,
                  controller: controller.FeedBackController,
                  hintText: StringsUtils.feedback,
                  textInputType: TextInputType.text,
                  maxLines: 4,
                  color: AppColor.backgroundColor,
                  textStyle: const TextStyle(color: AppColor.grey, fontSize: 14,fontFamily: "Customtext"),
                  style: const TextStyle(fontSize: 16, color: AppColor.black),
                  cursorColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
                child: ReviewSlider(
                    optionStyle: const TextStyle(color: AppColor.darkBlue,fontFamily: "Customtext"),
                    onChange: (int value) {
                      print(value);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.darkBlue, // Background color
                        ),
                        onPressed: () async {
                          if (controller.emailFeedBackController.text.isNotEmpty &&
                              controller.FeedBackController.text.isNotEmpty) {
                            controller.validateEmail(
                                controller.emailFeedBackController.text);
                            await controller.emailFeedBackController.text;
                            await controller.FeedBackController.text;
                            var feedEmail = controller.emailFeedBackController.text;
                            var feed = controller.FeedBackController.text;
                            print("feedEmail:-$feedEmail");
                            print("feed:-$feed");
                            Get.back();
                            controller.emailFeedBackController.clear();
                            controller.FeedBackController.clear();
                          } else {
                            AppSnackBar.showErrorSnackBar(
                              Icon: const Icon(Icons.feedback,
                                  color: AppColor.backgroundColor),
                              message: StringsUtils.pleaseEmail,
                              title: StringsUtils.sendFeedBack,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                        child: Center(
                          child: Row(
                            children: const [
                              Icon(Icons.send,color: AppColor.backgroundColor,),
                              SizedBox(width: 1,),
                              Text(
                                StringsUtils.sendFeedBack,
                                style: TextStyle(color: AppColor.backgroundColor,fontFamily: "Customtext"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
