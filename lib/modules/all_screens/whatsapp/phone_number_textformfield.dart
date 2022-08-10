import 'dart:io';
import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneNumberTextFormField extends StatelessWidget {
   PhoneNumberTextFormField({Key? key}) : super(key: key);
AllScreenController controller = Get.find();
ThemeController _themeController = Get.find();

   @override
  Widget build(BuildContext context) {
    return FocusScope(
      node:  FocusScopeNode(),
      child: TextFormField(
        // enableInteractiveSelection: true,
        toolbarOptions:  ToolbarOptions(
          paste: false,
          copy: true,
          selectAll: true,
          cut: true,
        ),
        controller: controller.numberController,
        enabled: true,

        /// keyBord
        // onTap: () async {
        //   FocusScope.of(context).unfocus();
        //   await Future.delayed(
        //       const Duration(milliseconds: 200));
        //   showNumericContainer.value = true;
        // },
        // onTap: () {
        //   // _homePageController.isShowDialPad.value = false;
        //   // _homePageController.isShowCallHistory.value = true;
        // },
        /// keyBord
        // onChanged: (value) {
        //   value = controller.numberController.text;
        // },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter(RegExp(r'[0-9+]'),
              allow: true)
        ],
        style: TextStyle(
            color: _themeController.isSwitched.value ? AppColor.black : AppColor.darkBlue,
            fontSize:
            SizeUtils.horizontalBlockSize * 5),
        showCursor: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 13),
          suffixIcon: SizedBox(
            width: SizeUtils.horizontalBlockSize * 18,
            child: Padding(
              padding: EdgeInsets.only(
                  right: SizeUtils.horizontalBlockSize *
                      4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      List<String> Number = await SharedPrefs.getNumberList();
                      var number = controller.numberController.text = Number.last;
                      print("Number:-  $number");
                    },
                    child: Icon(
                      Icons.history,
                      size:
                      SizeUtils.verticalBlockSize *
                          3,
                      color: AppColor.appGreen,
                    ),
                  ),
                  Platform.isAndroid
                      ? const SizedBox(
                    width: 3,
                  )
                      : const SizedBox(),
                  Platform.isAndroid
                      ? GestureDetector(
                      onLongPress: () {
                        controller.numberController
                            .clear();
                      },
                      onTap: () {
                        controller.numberController
                            .text =
                            controller
                                .numberController
                                .text
                                .substring(
                                0,
                                controller
                                    .numberController
                                    .text
                                    .length -
                                    1);
                      },
                      child: Icon(
                        Icons.clear,
                        size: SizeUtils
                            .verticalBlockSize *
                            2.7,
                        color: AppColor.appGreen,
                      )
                    // Image.asset(
                    //   AppString.iconBack,
                    //   height: SizeUtils
                    //           .horizontalBlockSize *
                    //       6,
                    // ),
                  )
                      : const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          ),
          hintText: StringsUtils.phoneNumber,
          hintStyle: TextStyle(
              fontFamily: 'Customtext',
              color:  _themeController.isSwitched.value ?AppColor.white :AppColor.darkBlue.withOpacity(0.6),
              fontSize: SizeUtils.horizontalBlockSize * 4),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
