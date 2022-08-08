// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:notes_with_login_management/screen/auth/log_in/login_with_google_mobile_facebook/mobile_login/mobile_login_controller/mobile_login_controller.dart';
// import 'package:notes_with_login_management/utils/app_color.dart';
// import 'package:notes_with_login_management/utils/app_string.dart';
// import 'package:notes_with_login_management/utils/navigation_utils/navigation.dart';
// import 'package:notes_with_login_management/widget/custom_textfield_view.dart';
// import 'package:sizer/sizer.dart';
//
// class MobileLogin extends StatelessWidget {
//   MobileLogin({Key? key}) : super(key: key);
//   MobileLoginController mobileLoginController =
//       Get.put(MobileLoginController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.auth,
//       body: SafeArea(
//         child: Obx(
//           () => Column(
//             children: [
//               Expanded(
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: 20.h),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.white,
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(40),
//                                       topRight: Radius.circular(40)),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 10.w, vertical: 1.h),
//                                   child: Column(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           AppString.logInWithPhone,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 30.sp,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 2.h,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 5.w, vertical: 2.h),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             CustomTextField(
//                                               textEditingController:
//                                                   mobileLoginController
//                                                       .contactNumber,
//                                               titleText: AppString.contactNo,
//                                               textInputAction:
//                                                   TextInputAction.done,
//                                               hintText:
//                                                   AppString.yourContactNumber,
//                                               keyboardType: TextInputType.phone,
//                                             ),
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
//                                             SizedBox(
//                                               height: 6.h,
//                                               width: double.infinity,
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   mobileLoginController.mobileLogin(
//                                                       contact:
//                                                           "+91${mobileLoginController.contactNumber.text.trim()}");
//                                                 },
//                                                 style: ButtonStyle(
//                                                   backgroundColor:
//                                                       MaterialStateProperty.all(
//                                                           AppColors
//                                                               .buttonColor),
//                                                   padding:
//                                                       MaterialStateProperty.all(
//                                                     EdgeInsets.symmetric(
//                                                         vertical: 2.h),
//                                                   ),
//                                                   shape:
//                                                       MaterialStateProperty.all<
//                                                           RoundedRectangleBorder>(
//                                                     RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               18.0),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 child: const Text(
//                                                     AppString.getOtp),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 const SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () =>
//                                                       Get.toNamed(Routes.login),
//                                                   child: const Text(
//                                                     AppString.backToLogin,
//                                                     style: TextStyle(
//                                                         color: AppColors
//                                                             .buttonColor),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 20.h,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Positioned(
//                     //   top: 5.h,
//                     //   child: SizedBox(
//                     //     height: 30.h,
//                     //     child: Padding(
//                     //       padding:
//                     //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
//                     //       child: Image(image: AssetImage(AppImages.login)),
//                     //     ),
//                     //   ),
//                     // ),
//                     mobileLoginController.mobileLoading.value
//                         ? Container(
//                             height: 100.h,
//                             color: Colors.grey.withOpacity(0.5),
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10.h, horizontal: 20.w),
//                                 child:
//                                     Lottie.asset('assets/lottie/lottie.json'),
//                               ),
//                             ),
//                           )
//                         : const SizedBox(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
