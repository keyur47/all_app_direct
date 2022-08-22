import 'dart:io';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MessagesTextFormField extends StatelessWidget {
  MessagesTextFormField({Key? key}) : super(key: key);

  AllScreenController controller = Get.put(AllScreenController());
  ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomeTextField(
            controller: controller.textController,
            radius: SizeUtils.horizontalBlockSize * 10,
            hintText: StringsUtils.typeYourMessage,
            showCursor: false,
            keyboardType: TextInputType.text,
            textInputFormatter: <TextInputFormatter>[
              FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: SizeUtils.verticalBlockSize * 1.5),
          child: controller.messageSizeButton.value
              ? SizedBox(
                  width: SizeUtils.horizontalBlockSize * 18,
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.messageSizeButton.value =
                                !controller.messageSizeButton.value;
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            size: SizeUtils.verticalBlockSize * 3,
                            color: AppColor.appIconColor,
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
                                  controller.textController.clear();
                                },
                                onTap: () {
                                  controller.textController.text =
                                      controller.textController.text.substring(
                                          0,
                                          controller.textController.text.length -
                                              1);
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: SizeUtils.verticalBlockSize * 2.7,
                                  color: AppColor.appIconColor,
                                ))
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: SizeUtils.horizontalBlockSize * 18,
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.messageSizeButton.value =
                                !controller.messageSizeButton.value;
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            size: SizeUtils.verticalBlockSize * 3,
                            color: AppColor.appIconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

// FocusScope(
// node:  FocusScopeNode(),
// child: TextFormField(
// maxLines: null,
// enableInteractiveSelection: true,
// toolbarOptions: const ToolbarOptions(
// paste: false,
// copy: true,
// selectAll: true,
// cut: true,
// ),
// controller: controller.textController,
// enabled: true,
// // onTap: () {
// //   showNumericContainer.value = false;
// // },
// // onTap: () {
// //   // _homePageController.isShowDialPad.value = false;
// //   // _homePageController.isShowCallHistory.value = true;
// // },
// onChanged: (value) {
// value = controller.textController.text;
// },
// style: TextStyle(
// color: AppColor.black,
// fontSize:
// SizeUtils.horizontalBlockSize * 5),
// showCursor: false,
// keyboardType: TextInputType.text,
// decoration: InputDecoration(
// border: InputBorder.none,
// focusedBorder: InputBorder.none,
// enabledBorder: InputBorder.none,
// errorBorder: InputBorder.none,
// disabledBorder: InputBorder.none,
// suffixIcon: controller.messageSizeButton.value
// ? SizedBox(
// width:
// SizeUtils.horizontalBlockSize *
// 18,
// child: Padding(
// padding: EdgeInsets.only(
// right: SizeUtils
//     .horizontalBlockSize *
// 4),
// child: Row(
// mainAxisSize: MainAxisSize.min,
// mainAxisAlignment:
// MainAxisAlignment.end,
// children: [
// GestureDetector(
// onTap: () async {
// controller.messageSizeButton.value =
// !controller
//     .messageSizeButton.value;
// },
// child: Icon(
// Icons.add_circle_outline,
// size: SizeUtils
//     .verticalBlockSize *
// 3,
// color: AppColor.appIconColor,
// ),
// ),
// Platform.isAndroid
// ? const SizedBox(
// width: 3,
// )
// : const SizedBox(),
// Platform.isAndroid
// ? GestureDetector(
// onLongPress: () {
// controller
//     .textController
//     .clear();
// },
// onTap: () {
// controller
//     .textController
//     .text =
// controller
//     .textController
//     .text
//     .substring(
// 0,
// controller.textController.text.length -
// 1);
// },
// child: Icon(
// Icons.clear,
// size: SizeUtils
//     .verticalBlockSize *
// 2.7,
// color: AppColor
//     .appIconColor,
// ))
// : const SizedBox(
// height: 0,
// ),
// ],
// ),
// ),
// )
// : SizedBox(
// width:
// SizeUtils.horizontalBlockSize *
// 18,
// child: Padding(
// padding: EdgeInsets.only(
// right: SizeUtils
//     .horizontalBlockSize *
// 4),
// child: Row(
// mainAxisSize: MainAxisSize.min,
// mainAxisAlignment:
// MainAxisAlignment.end,
// children: [
// GestureDetector(
// onTap: () async {
// controller.messageSizeButton.value =
// !controller
//     .messageSizeButton.value;
// },
// child: Icon(
// Icons.add_circle_outline,
// size: SizeUtils
//     .verticalBlockSize *
// 3,
// color: AppColor.appIconColor,
// ),
// ),
// ],
// ),
// ),
// ),
// hintText: StringsUtils.typeYourMessage,
// hintStyle: TextStyle(
// fontFamily: 'Customtext',
// color:  _themeController.isSwitched.value ?AppColor.white :AppColor.darkBlue.withOpacity(0.6),
// fontSize:
// SizeUtils.horizontalBlockSize * 4),
// ),
// ),
// );
