import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/button_box.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUserNameSnapchat extends StatelessWidget {
  OpenUserNameSnapchat({Key? key}) : super(key: key);

  AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return button(
        onTap: () async {
          if (controller
              .snapchatUsernameController.text.isNotEmpty){
            controller.setSnapchatUsernameList.addAll([(controller.snapchatUsernameController.text)]);
            SharedPrefs.setSnapchatList(controller.setSnapchatUsernameList);
            controller.url.value = "https://www.snapchat.com/add/${controller.snapchatUsernameController.text}/";
            await launch(controller.url.value);
            await controller.getSnapchatData();
            print("------${controller.url.value}");
          } else {
            AppToast.toastMessage("Enter Username");
            // AppSnackBar.showErrorSnackBar(
            //   Icon: const Icon(Icons.people_alt_rounded,color: Colors.blue),
            //   message: StringsUtils.pleaseUsername,
            //   title: StringsUtils.userNameTelegram,
            //   snackPosition: SnackPosition.BOTTOM,
            // );
          }
        },
        text: StringsUtils.snapchat,
        iconData: BootstrapIcons.snapchat,
        scale: SizeUtils.horizontalBlockSize* 3,
        top: SizeUtils.horizontalBlockSize*  2,
        left: SizeUtils.horizontalBlockSize* 3.5,
        right: SizeUtils.horizontalBlockSize* 1.2,
        bottom: SizeUtils.horizontalBlockSize* 2.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5)
        ),
        iconColor: AppColor.appIconColor);
  }
}


