import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/widgets/fade_slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// /// usernameTextField
// Widget usernameTextField({
//   required TextEditingController? controller,
//   required bool? showCursor,
//   required String? hintText,
//   required TextInputType textInputType,
//   required GestureTapCallback onTap,
//   required GestureLongPressCallback?  longPress,
// }) {
//   ThemeController themeController = Get.find();
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 10),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 4,
//           offset: Offset(4, 8), // Shadow position
//         ),
//       ],
//     ),
//     child: TextFormField(
//       cursorColor: Colors.transparent,
//         controller: controller,
//         toolbarOptions: const ToolbarOptions(
//           paste: false,
//           copy: true,
//           selectAll: true,
//           cut: true,
//         ),
//         showCursor: false,
//         inputFormatters: <TextInputFormatter>[
//           FilteringTextInputFormatter(RegExp(r'[a-z_.0-9]'), allow: true)
//         ],
//         decoration: InputDecoration(
//             enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(SizeUtils.horizontalBlockSize * 10),
//                 borderSide: BorderSide.none),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(SizeUtils.horizontalBlockSize * 10),
//                 borderSide: BorderSide.none),
//             enabled: true,
//             contentPadding:
//                 EdgeInsets.only(top: SizeUtils.verticalBlockSize * 1.7),
//             border: InputBorder.none,
//             prefixIcon:  Icon(
//               Icons.search,
//                 color: themeController.isSwitched.value ? AppColor.white: AppColor.appIconColor,
//             ),
//             suffixIcon: GestureDetector(
//                 onTap: onTap,
//                 onLongPress: longPress,
//                 child:  Icon(Icons.close,color: themeController.isSwitched.value ? AppColor.white: AppColor.appIconColor)),
//             hintText: hintText,
//             fillColor: themeController.isSwitched.value ? AppColor.grey[200] : AppColor.white,
//             filled: true,
//             hintStyle:  TextStyle(fontSize: 16,color: themeController.isSwitched.value ? AppColor.white: AppColor.darkBlue.withOpacity(0.6)))),
//   );
// }

class CustomeTextField extends StatelessWidget {
  ThemeController themeController = Get.find();

  CustomeTextField(
      {Key? key,
      this.fontSize,
      this.toolbarOptions,
      this.onTap,
      this.hintStyle,
      this.suffixIcon,
      this.onChanged,
      this.keyboardType,
      this.radius,
      this.fillColor,
      this.maxLength,
      this.textColor,
      required this.controller,
      this.maxLine,
      this.validator,
      this.contentPadding,
      this.labelText,
      this.textInputType,
      this.showCursor,
      this.isPassword = false,
      this.hintText,
      this.isSearch = false,
      this.isBoxShadow = false,
      this.boxShadow,
      this.longPress,
      this.textInputFormatter,
      this.prefixIcon,
      this.readOnly,
      this.isDense})
      : super(key: key);
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int? maxLine;
  final Color? textColor;
  final double? fontSize;
  final bool isPassword;
  final bool isSearch;
  final bool? showCursor;
  final TextInputType? textInputType;
  final int? maxLength;
  final double? radius;
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final Widget? suffixIcon;
  final Color? fillColor;
  final GestureLongPressCallback? longPress;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;
  final String? hintText;
  final bool? isDense;
  final bool? readOnly;
  final TextStyle? hintStyle;
  final ToolbarOptions? toolbarOptions;
  final Widget? prefixIcon;
  final List<BoxShadow>? boxShadow;
  final bool isBoxShadow;

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return ValueListenableBuilder(
        valueListenable: _isObscure,
        builder: (context, bool isObscure, _) {
          if (!isPassword) {
            isObscure = false;
          }
          return IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
                boxShadow: boxShadow == null && isBoxShadow
                    ? const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ]
                    : boxShadow,
              ),
              // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius ?? 10))),
              child: TextFormField(
                maxLength: maxLength,
                toolbarOptions: toolbarOptions,
                keyboardType: keyboardType,
                controller: controller,
                obscureText: isObscure,
                onTap: onTap,
                style: TextStyle(
                    color: themeController.isSwitched.value
                        ? AppColor.black
                        : AppColor.darkBlue,
                    fontSize: SizeUtils.horizontalBlockSize * 5),
                showCursor: false,
                readOnly: readOnly ?? false,
                inputFormatters: [],
                decoration: InputDecoration(
                  fillColor: themeController.isSwitched.value
                      ? AppColor.grey[200]
                      : AppColor.white,
                  filled: true,
                  isDense: isDense,
                  border: InputBorder.none,
                  disabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius ?? 10)),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius ?? 10)),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius ?? 10)),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  // labelText: labelText,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(radius ?? 10),
                  //   ),
                  //   borderSide: BorderSide(color: AppColors.textFillColor, width: 0),
                  // ),

                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: themeController.isSwitched.value
                          ? AppColor.white
                          : AppColor.darkBlue.withOpacity(0.6)),
                  suffixIcon: suffixIcon == null && isPassword
                      ? IconButton(
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _isObscure.value = !isObscure;
                          },
                        )
                      : suffixIcon,
                  prefixIcon: prefixIcon == null && isSearch
                      ? Icon(
                          Icons.search,
                          color: AppColor.appIconColor,
                        )
                      : prefixIcon,
                  contentPadding: contentPadding ??
                      EdgeInsets.only(
                          top: SizeUtils.verticalBlockSize * 2,
                          left: SizeUtils.horizontalBlockSize * 5),
                ),
                validator: validator,
                maxLines: maxLine,
              ),
            ),
          );
        });
  }
}

/// entryField
Widget entryField(
  String title,
  ValueChanged<String>? onChanged,
  String hinText,
  TextEditingController TextEditingController,
  Animation<double> animation, {
  bool obscure = false,
  Widget? suffixIcon,
}) {
  ThemeController themeController = Get.find();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: themeController.isSwitched.value
                  ? AppColor.white
                  : AppColor.darkBlue),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: themeController.isSwitched.value
                    ? AppColor.black
                    : AppColor.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          child: FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: TextFormField(
                controller: TextEditingController,
                obscureText: obscure,
                onChanged: onChanged,
                style: TextStyle(
                    color: themeController.isSwitched.value
                        ? AppColor.white
                        : AppColor.grey),
                decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    hintText: hinText,
                    hintStyle: TextStyle(
                        color: themeController.isSwitched.value
                            ? AppColor.white
                            : AppColor.grey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 15),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColor.red, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: themeController.isSwitched.value
                        ? AppColor.grey[200]
                        : AppColor.white,
                    filled: true)),
          ),
        )
      ],
    ),
  );
}
