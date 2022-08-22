import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenCalls extends StatefulWidget {
  OpenCalls({Key? key}) : super(key: key);

  @override
  State<OpenCalls> createState() => _OpenCallsState();
}

class _OpenCallsState extends State<OpenCalls> {
  AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return button(
      onTap: () async {
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
      scale: SizeUtils.horizontalBlockSize * 3,
      top: SizeUtils.horizontalBlockSize * 2.4,
      left: SizeUtils.horizontalBlockSize * 2.5,
      right: SizeUtils.horizontalBlockSize * 1,
      bottom: SizeUtils.horizontalBlockSize * 2,
      iconColor: AppColor.appIconColor,
      sizeIcon: SizeUtils.horizontalBlockSize * 7,
    );
  }
}
