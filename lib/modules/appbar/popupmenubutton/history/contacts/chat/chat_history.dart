// import 'package:direct_whatsapp/modules/appbar/popupmenubutton/feedback/feedback.dart';
// import 'package:direct_whatsapp/modules/appbar/popupmenubutton/history/bottom_navigationbar.dart';
// import 'package:direct_whatsapp/utils/app_color.dart';
// import 'package:direct_whatsapp/widgets/route_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class ChatHistory extends StatelessWidget {
//   ChatHistory({required this.chat, required this.number});
//
//   List chat = [];
//   String number = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           leading: GestureDetector(
//               onTap: () {
//                 Get.offAllNamed(Routes.tabbar);
//               },
//               child: Icon(Icons.arrow_back)),
//           toolbarHeight: 8.h,
//           backgroundColor: AppColors.darkBlue,
//           title: Column(
//             children: [
//               Text(number),
//               // Text(data)
//             ],
//           ),
//         ),
//         body: controller.chatContactsNumberList.isNotEmpty
//             ? Center(
//                 child: Image.asset(
//                 "assets/image/no_data.png",
//                 scale: 5,
//               ))
//             : ListView.builder(
//                 itemCount: chat.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding:  EdgeInsets.only(left: 3.w,top: 1.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: AppColors.darkBlue,
//                             borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20) )
//                           ),
//                             child: Padding(
//                               padding:  EdgeInsets.only(top: 1.h,bottom:1.h,left: 5.w,right: 2.w),
//                               child: Text(chat[index],style: TextStyle(color: AppColor.backgroundColor,fontSize: 18),),
//                             )),
//                       ],
//                     ),
//                   );
//                 },
//               ));
//   }
// }
