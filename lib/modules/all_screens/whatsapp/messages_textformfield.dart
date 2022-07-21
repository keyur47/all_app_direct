import 'dart:io';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesTextFormField extends StatelessWidget {
   MessagesTextFormField({Key? key}) : super(key: key);

  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node:  FocusScopeNode(),
      child: TextFormField(
        maxLines: null,
        enableInteractiveSelection: true,
        toolbarOptions: const ToolbarOptions(
          paste: false,
          copy: true,
          selectAll: true,
          cut: true,
        ),
        controller: controller.textController,
        enabled: true,
        // onTap: () {
        //   showNumericContainer.value = false;
        // },
        // onTap: () {
        //   // _homePageController.isShowDialPad.value = false;
        //   // _homePageController.isShowCallHistory.value = true;
        // },
        onChanged: (value) {
          value = controller.textController.text;
        },
        style: TextStyle(
            color: AppColor.darkBlue,
            fontSize:
            SizeUtils.horizontalBlockSize * 5),
        showCursor: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: controller.collpan.value
              ? SizedBox(
            width:
            SizeUtils.horizontalBlockSize *
                18,
            child: Padding(
              padding: EdgeInsets.only(
                  right: SizeUtils
                      .horizontalBlockSize *
                      4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      controller.collpan.value =
                      !controller
                          .collpan.value;
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      size: SizeUtils
                          .verticalBlockSize *
                          3,
                      color: AppColor.appColors,
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
                        controller
                            .textController
                            .clear();
                      },
                      onTap: () {
                        controller
                            .textController
                            .text =
                            controller
                                .textController
                                .text
                                .substring(
                                0,
                                controller.textController.text.length -
                                    1);
                      },
                      child: Icon(
                        Icons.clear,
                        size: SizeUtils
                            .verticalBlockSize *
                            2.7,
                        color: AppColor
                            .appColors,
                      ))
                      : const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          )
              : SizedBox(
            width:
            SizeUtils.horizontalBlockSize *
                18,
            child: Padding(
              padding: EdgeInsets.only(
                  right: SizeUtils
                      .horizontalBlockSize *
                      4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      controller.collpan.value =
                      !controller
                          .collpan.value;
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      size: SizeUtils
                          .verticalBlockSize *
                          3,
                      color: AppColor.appColors,
                    ),
                  ),
                ],
              ),
            ),
          ),
          hintText: StringsUtils.typeYourMessage,
          hintStyle: TextStyle(
              fontFamily: 'Customtext',
              color:
              AppColor.darkBlue.withOpacity(0.6),
              fontSize:
              SizeUtils.horizontalBlockSize * 4),
        ),
      ),
    );
  }
}
