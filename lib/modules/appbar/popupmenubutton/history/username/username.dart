// import 'dart:math';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:direct_whatsapp/helper/shared_preferences.dart';
// import 'package:direct_whatsapp/modules/allscreen/instagram/instagram_screen.dart';
// import 'package:direct_whatsapp/modules/allscreen/telegram/telegram_screen.dart';
// import 'package:direct_whatsapp/modules/controller/all_screen_controller.dart';
// import 'package:direct_whatsapp/utils/app_color.dart';
// import 'package:direct_whatsapp/utils/string_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class UserName extends StatefulWidget {
//   UserName({Key? key}) : super(key: key);
//   static const routeName = '/username_screen';
//
//   @override
//   State<UserName> createState() => _UserNameState();
// }
//
// class _UserNameState extends State<UserName> {
//   Controller controller = Get.find();
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     controller.usernameList = await SharedPrefs.getUserNameList();
//     controller.dateTime = await SharedPrefs.getDateTimeList();
//     controller.toSetUsernameList = controller.usernameList.toSet().toList();
//
//     setState(() {
//       controller.usernameList.join("");
//       controller.dateTime.join("");
//     });
//     print("------------>>>${controller.usernameList}");
//     print("------------>>>${controller.dateTime}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         toolbarHeight: 8.h,
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.darkBlue,
//         title: DefaultTextStyle(
//           style: const TextStyle(
//               fontSize: 22.0,
//               fontFamily: 'Customtext',
//               color: AppColor.backgroundColor),
//           child: AnimatedTextKit(
//             pause: Duration(milliseconds: 100),
//             animatedTexts: [
//               TypewriterAnimatedText(StringsUtils.userNameHistory),
//             ],
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           // usernameAppbar(text: "${StringsUtils.userNameHistory}"),
//           controller.toSetUsernameList.isEmpty
//               ? Center(
//                   child: Image.asset(
//                   "assets/image/no_data.png",
//                   scale: 5,
//                 ))
//               : Padding(
//                   padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: controller.toSetUsernameList.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           SwipeActionCell(
//                             key: ObjectKey(
//                               controller.toSetUsernameList[index],
//                             ),
//                             trailingActions: <SwipeAction>[
//                               SwipeAction(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onTap: (CompletionHandler handler) async {
//                                     await controller.toSetUsernameList.removeAt(index)[index];
//                                     await SharedPrefs.setUserNameList(controller.toSetUsernameList);
//                                     setState(() {});
//                                   },
//                                   color: Colors.transparent),
//                             ],
//                             child: Container(
//                               height: 7.h,
//                               decoration: BoxDecoration(
//                                   color: AppColor.backgroundColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(width: 1)),
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 2.w,
//                                 ),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         context: context,
//                                         shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                             top: Radius.circular(25.0),
//                                           ),
//                                         ),
//                                         builder: (context) {
//                                           return SizedBox(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                         top: 0.5.h),
//                                                     child: ListTile(
//                                                       leading:
//                                                           Icon(Icons.whatsapp),
//                                                       title: GestureDetector(
//                                                           onTap: () {
//                                                             controller
//                                                                 .telegramUsernameController
//                                                                 .text = controller
//                                                                     .toSetUsernameList[
//                                                                 index];
//                                                             Get.to(Telegram());
//                                                           },
//                                                           child:
//                                                               Text("Telegram")),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                         bottom: 0.5.h),
//                                                     child: ListTile(
//                                                       leading:
//                                                           Icon(Icons.message),
//                                                       title: GestureDetector(
//                                                           onTap: () {
//                                                             controller
//                                                                 .instagramUsernameController
//                                                                 .text = controller
//                                                                     .toSetUsernameList[
//                                                                 index];
//                                                             Get.to(Instagram());
//                                                           },
//                                                           child: Text(
//                                                               "Instagram")),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         });
//                                   },
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor:
//                                         Colors.primaries[Random().nextInt(Colors.primaries.length)],
//                                         child: Stack(
//                                           children: [
//                                             // Text(
//                                             //   "${controller.nameTelegramList[index].substring(0, 1).toUpperCase()}",
//                                             //   style: TextStyle(
//                                             //     fontSize: 24,
//                                             //     foreground: Paint()
//                                             //       ..style = PaintingStyle.stroke
//                                             //       ..strokeWidth = 6
//                                             //       ..color = Colors.black12,
//                                             //   ),
//                                             // ),
//                                             Text(
//                                               "${controller.toSetUsernameList[index].substring(0, 1).toUpperCase()}",
//                                               style: TextStyle(
//                                                 fontSize: 24,
//                                                 color: Colors.white,
//                                                   fontFamily: "Customtext"
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left: 2.w,
//                                           top: 1.2.h,
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "${controller.toSetUsernameList[index].toUpperCase()}",
//                                               style: TextStyle(
//                                                   color: AppColors.black,
//                                                   fontFamily: "Customtext",
//                                                   fontSize: 16),
//                                             ),
//                                             Text(
//                                               "${controller.dateTime[index]}",
//                                               style: TextStyle(
//                                                   color: AppColors.black,
//                                                   fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 1.h,
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
