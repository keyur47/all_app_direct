// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:direct_whatsapp/helper/shared_preferences.dart';
// import 'package:direct_whatsapp/modules/controller/all_screen_controller.dart';
// import 'package:direct_whatsapp/utils/app_color.dart';
// import 'package:direct_whatsapp/utils/string_utils.dart';
// import 'package:direct_whatsapp/widgets/call.dart';
// import 'package:direct_whatsapp/widgets/route_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'chat/chat_history.dart';
//
// class ContactsList extends StatefulWidget {
//
//   @override
//   State<ContactsList> createState() => _ContactsListState();
// }
//
// class _ContactsListState extends State<ContactsList> {
//   Controller controller = Get.find();
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     controller.contactsNumberList = await SharedPrefs.getNumberList();
//     controller.countryNumberList = await SharedPrefs.getCountryNumberList();
//     controller.countryNameList = await SharedPrefs.getCountryNameList();
//     controller.dateTime = await SharedPrefs.getDateTimeList();
//     controller.toSetContactsNumberList = controller.contactsNumberList.toSet().toList();
//     // controller.dateTime.sort((a, b) {
//     //   var adate = a; //before -> var adate = a.expiry;
//     //   var bdate = b;
//     //   return -adate.compareTo(bdate);
//     // });
//     setState(() {
//       controller.contactsNumberList.join("");
//       controller.countryNumberList.join("");
//       controller.countryNameList.join("");
//       controller.dateTime.join("");
//       controller.toSetContactsNumberList.join("");
//     });
//     print("------numberList------>>>${controller.contactsNumberList}");
//     print("------countryList------>>>${controller.countryNumberList}");
//     print("------nameCountryList------>>>${controller.countryNameList}");
//     print("------dateTime------>>>${controller.dateTime}");
//     print("------getNumberList------>>>${controller.toSetContactsNumberList}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         toolbarHeight: 8.h,
//         backgroundColor: AppColors.darkBlue,
//         title: DefaultTextStyle(
//           style: const TextStyle(
//               fontSize: 22.0,
//               fontFamily: 'Customtext',
//               color: AppColor.backgroundColor),
//           child: AnimatedTextKit(
//             pause: Duration(milliseconds: 100),
//             animatedTexts: [
//               TypewriterAnimatedText("${StringsUtils.contactsHistory}"),
//             ],
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           // contactsAppbar(iconData: Icons.arrow_back_rounded ,text: "${StringsUtils.contactsHistory}",),
//           controller.toSetContactsNumberList.isEmpty
//               ? Center(
//                   child: Image.asset(
//                   "assets/image/no_data.png",
//                   scale: 5,
//                 ))
//               :
//           Padding(
//                   padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: controller.toSetContactsNumberList.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           SwipeActionCell(
//                             key: ObjectKey(
//                               controller.toSetContactsNumberList[index],
//                             ),
//                             trailingActions: <SwipeAction>[
//                               SwipeAction(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onTap: (CompletionHandler handler) async {
//                                     await controller.toSetContactsNumberList.removeAt(index)[index];
//                                     await SharedPrefs.setNumberList(controller.toSetContactsNumberList);
//                                     setState(() {});
//                                   },
//                                   color: Colors.transparent),
//                             ],
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     color: AppColor.backgroundColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(width: 1)),
//                                 child: InkWell(
//                                   onTap: () {},
//                                   child: Theme(
//                                     data: Theme.of(context)
//                                         .copyWith(accentColor: Colors.black),
//                                     child: ExpansionTile(
//                                         childrenPadding:
//                                             EdgeInsets.only(right: 3.w),
//                                         trailing: GestureDetector(
//                                             onTap: () async {
//                                               ///contacts number list
//                                               controller
//                                                   .callAndMessagesNumberController
//                                                   .text = controller
//                                                       .toSetContactsNumberList[
//                                                   index];
//                                               ///country number list
//                                               controller
//                                                       .callCountryNumberController
//                                                       .text =
//                                                   controller
//                                                       .countryNumberList[index];
//                                               //FlutterPhoneDirectCaller.callNumber("+${_countryCtrl.text}${_numberCtrl.text}");
//                                               makePhoneCall(
//                                                   contact:
//                                                       "+${controller.callCountryNumberController.text}${controller.callAndMessagesNumberController.text}",
//                                                   direct: true);
//                                             },
//                                             child: Icon(Icons.call)),
//                                         tilePadding: EdgeInsets.only(
//                                             left: 2.w, right: 5.w),
//                                         textColor: AppColors.black,
//                                         iconColor: AppColors.black,
//                                         title: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             CircleAvatar(
//                                               backgroundColor: AppColors.darkBlue,
//                                               child: Text(
//                                                 "+${controller.countryNumberList[index]}",
//                                                 style: TextStyle(
//                                                     color: AppColors.white,
//                                                     fontFamily: "Customtext",
//                                                     fontSize: 12),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: 0.3.h, left: 2.w),
//                                                 child: GestureDetector(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                           "${controller.toSetContactsNumberList[index]}",
//                                                           style: TextStyle(
//                                                               color: AppColors
//                                                                   .black,
//                                                               fontSize: 16)),
//                                                       Row(
//                                                         children: [
//                                                           Icon(
//                                                             BootstrapIcons
//                                                                 .arrow_up_right,
//                                                             size: 12,
//                                                           ),
//                                                           Text(
//                                                               "${controller.countryNameList[index]}",
//                                                               style: TextStyle(
//                                                                   color:
//                                                                       AppColors
//                                                                           .red,
//                                                                   fontSize:
//                                                                       14)),
//                                                           Text(" \u2022 "),
//                                                           Text(
//                                                             "${(controller.dateTime[index])}",
//                                                             style: TextStyle(
//                                                                 fontSize: 13),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         children: <Widget>[
//                                           ListTile(
//                                             title: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     controller
//                                                         .numberController
//                                                         .text = controller
//                                                             .toSetContactsNumberList[
//                                                         index];
//                                                     controller.countryNumber
//                                                         .value = controller
//                                                             .countryNumberList[
//                                                         index];
//                                                     controller
//                                                             .countryName.value =
//                                                         controller
//                                                                 .countryNameList[
//                                                             index];
//                                                     Get.offAllNamed(
//                                                         Routes.whatsapp);
//                                                   },
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(Icons.whatsapp),
//                                                       Text(
//                                                         "WhatsApp",
//                                                         style: TextStyle(
//                                                             fontSize: 14),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     controller
//                                                         .callAndMessagesNumberController
//                                                         .text = controller
//                                                             .toSetContactsNumberList[
//                                                         index];
//                                                     controller.countryNumber
//                                                         .value = controller
//                                                             .countryNumberList[
//                                                         index];
//                                                     Get.offAllNamed(
//                                                         Routes.messages);
//                                                   },
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(Icons.message),
//                                                       Text(
//                                                         "Messages",
//                                                         style: TextStyle(
//                                                             fontSize: 14),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     // Get.offAllNamed(ChatHistory.routeName);
//                                                     Get.back();
//                                                   },
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.history,
//                                                         size: 7.w,
//                                                       ),
//                                                       Text(
//                                                         "History",
//                                                         style: TextStyle(
//                                                             fontSize: 14),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ]),
//                                   ),
//                                 )),
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
