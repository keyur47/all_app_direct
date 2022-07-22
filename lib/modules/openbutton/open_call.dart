
import 'package:all_app_direct/ads/adr.controller.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/appsnackbar.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/call.dart';
import 'package:all_app_direct/widgets/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenCalls extends StatefulWidget {
  OpenCalls({Key? key}) : super(key: key);

  @override
  State<OpenCalls> createState() => _OpenCallsState();
}

class _OpenCallsState extends State<OpenCalls> {
  AllScreenController controller = Get.find();
  AdController adController = Get.find();
  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
          await adController.createRewardedAd();
          await controller.getPermission();
          if (controller.numberController.text != "") {
            print("numberController");
            controller.onOpenCalls(controller.numberController.text);
            print("numberController11${controller.numberController.text}");
          } else {
            AppToast.toastMessage("Enter Mobile Number");
          }
        },
        text: StringsUtils.call,
        iconData: Icons.call_outlined,
        scale: SizeUtils.horizontalBlockSize* 3,
        top: SizeUtils.horizontalBlockSize*  2.5,
        left: SizeUtils.horizontalBlockSize* 2,
        right: SizeUtils.horizontalBlockSize* 1.5,
        bottom: SizeUtils.horizontalBlockSize* 2,
        boxColor: AppColor.white,
        iconColor:AppColor.appColors,
        sizeIcon: SizeUtils.horizontalBlockSize* 7
    );
  }
}
