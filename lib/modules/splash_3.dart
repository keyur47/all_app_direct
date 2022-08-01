// import 'package:all_app_direct/helper/shared_preferences.dart';
// import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
// import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
// import 'package:all_app_direct/widgets/newt_box_buttons.dart';
// import 'package:flutter/material.dart';
//
// class SplashBox3 extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       body: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Center(child: Text("SplashBox3")),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25,right: 15),
//             child: Align(
//                 alignment: Alignment.bottomRight,
//                 child:  boxNext(onTap: (){
//                   SharedPrefs.setPage("1");
//                   Navigation.popAndPushNamed(Routes.whatsapp);
//                 })),
//           )
//         ],
//       ),
//     );
//   }
// }
