
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



  Widget phoneNumberTextField({
    required TextEditingController? controller,
    required bool? showCursor,
    required String? hintText,
    required TextInputType textInputType,
    required GestureTapCallback onTap,
    required GestureLongPressCallback onLongPress,
    required ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(4, 8), // Shadow position
        ),
      ], borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: Center(
        child: FocusScope(
          node:  FocusScopeNode(),
          child: TextFormField(
              enableInteractiveSelection: true,
              controller: controller,
              toolbarOptions: const ToolbarOptions(
                paste: false,
                copy: true,
                selectAll: true,
                cut: true,
              ),
              autofocus: true,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter(RegExp(r'[0-9+]'), allow: true)
              ],
              onChanged: onChanged,
              decoration: InputDecoration(
                  enabled: true,
                  contentPadding: EdgeInsets.only(top: 1.8, left: 7),
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   color: AppColors.darkBlue,
                  // ),
                  suffixIcon: GestureDetector(
                      onTap: onTap,
                      onLongPress: onLongPress,
                      child: Icon(
                        Icons.close,
                        color: AppColor.darkBlue,
                        size: 6,
                      )),
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 16))),
        ),
      ),
    );
  }
///
Widget usernameTextField({
  required TextEditingController? controller,
  required bool? showCursor,
  required String? hintText,
  required TextInputType textInputType,
  required GestureTapCallback onTap,
}) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(4, 8), // Shadow position
        ),
      ], borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 10), color: Colors.white),
      child: TextFormField(
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter(RegExp(r'[a-z_.0-9]'), allow: true)
          ],
          decoration: InputDecoration(
              enabled: true,
              // contentPadding: EdgeInsets.only(top: SizeUtils.horizontalBlockSize * 3),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColor.darkBlue,
              ),
              suffixIcon: GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.close, color: AppColor.darkBlue)),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 16))),
    ),
  );
}

AllScreenController controller = Get.find();

///
Widget textField({
  required TextEditingController? controller,
  int? maxLines,
  required Color color,
  required TextStyle textStyle,
  required TextStyle style,
  //bool? showCursor,
  required FocusNode? focusNode,
  required String? hintText,
  required Color cursorColor,
  TextInputType? textInputType,
  required BoxBorder? boxBorder,
  ValueChanged<String>? valueChanged,
  FormFieldValidator<String>? validator,
  EdgeInsetsGeometry? contentPadding,
  MaxLengthEnforcement? maxLengthEnforcement,
  Widget? suffixIcon,
}) {
  return Container(
    decoration: BoxDecoration(
        border: boxBorder,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: EdgeInsets.only(left: 5, right: 2),
      child: TextFormField(
        toolbarOptions: const ToolbarOptions(
          paste: true,
          copy: true,
          selectAll: true,
          cut: true,
        ),
        enabled: true,
        // maxLines: maxLines,
        maxLines: null,
        // maxLength: 150,
        // maxLengthEnforcement: maxLengthEnforcement,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: textStyle,
          suffix: suffixIcon,
        ),
        controller: controller,
        onChanged: valueChanged,
        // showCursor: showCursor,
        style: style,
        keyboardType: textInputType,
        validator: validator,
        // focusNode: focusNode,
        cursorColor: cursorColor,
      ),
    ),
  );
}
