import 'dart:developer';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/setting_controller/setting_controller.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Setting extends StatefulWidget {
   Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting>  with WidgetsBindingObserver {
   Permission _permission = Permission.notification;

   @override
   void initState() {
     super.initState();
     WidgetsBinding.instance.addObserver(this);
   }

   @override
   void dispose() {
     WidgetsBinding.instance.removeObserver(this);
     super.dispose();
   }

   @override
   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
     switch (state) {
       case AppLifecycleState.resumed:
         log("app in resumed");
         await grantedPermission();
         break;
       case AppLifecycleState.inactive:
         await grantedPermission();
         log("app in inactive"); //app in background
         break;
       case AppLifecycleState.paused:
         log("app in paused"); //app in background
         break;
       case AppLifecycleState.detached:
         log("app in detached"); //app remove from background
         break;
     }
   }

   Future<void> grantedPermission() async {
     _permission = Permission.notification;
     final status = await _permission.isGranted;
     settingController.isNotificationCheck.value = status;
     SharedPrefs.setNotification(
         notification: settingController.isNotificationCheck.value);
   }

  ThemeController themeController = Get.find();

   SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorRes.backgroundColor(context),
      appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.only(left: 20,right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme Mode"),
                Obx(()=>
                   Switch(
                    activeColor: AppColor.primaryColor,
                    value: themeController.isSwitched.value,
                    onChanged: (value) {
                      themeController.isSwitched.value = value;
                      Get.changeThemeMode(
                        themeController.isSwitched.value == true
                            ? ThemeMode.dark
                            : ThemeMode.light,
                      );
                      SharedPrefs.setThemeBoolean("theme",
                          value: themeController.isSwitched.value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Notification"),
              Obx(()=>
                  Switch(
                    activeColor: AppColor.primaryColor,
                    value: settingController.isNotificationCheck.value,
                    onChanged: (value) {
                      AppSettings.openNotificationSettings();
                    },
                  ),
              ),
            ],)
          ],
        ),
      ),
    );
  }
}























// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:in_app_review/in_app_review.dart';
//
// class About extends StatefulWidget {
//   const About({Key? key}) : super(key: key);
//
//   @override
//   State<About> createState() => _AboutState();
// }
//
// class _AboutState extends State<About> {
//   final InAppReview _inAppReview = InAppReview.instance;
//   late bool _isAvailable;
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _inAppReview
//           .isAvailable()
//           .then(
//             (bool isAvailable) => setState(
//               () => _isAvailable = isAvailable && !Platform.isAndroid,
//         ),
//       )
//           .catchError((_) => setState(() => _isAvailable = false));
//     });
//   }
//   Future<void> _requestReview() => _inAppReview.requestReview();
//
//   Future<void> _openStoreListing() => _inAppReview.openStoreListing(
//     appStoreId: "id297606951",
//     // microsoftStoreId: _microsoftStoreId,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     const loadingMessage = 'LOADING';
//     const availableMessage = 'AVAILABLE';
//     const unavailableMessage = 'UNAVAILABLE';
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('InAppReview Example')),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'InAppReview status: ${_isAvailable == null ? loadingMessage : _isAvailable ? availableMessage : unavailableMessage}',
//             ),
//             ElevatedButton(
//               onPressed: _requestReview,
//               child: Text('Request Review'),
//             ),
//             ElevatedButton(
//               onPressed: _openStoreListing,
//               child: Text('Open Store Listing'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // import 'dart:async';
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:path/path.dart' as p;
// // import 'package:snapchat/snapchat.dart';
// //
// //
// // class snapchat extends StatefulWidget {
// //   @override
// //   _snapchatState createState() => _snapchatState();
// // }
// //
// // class _snapchatState extends State<snapchat> {
// //   SnapchatPlugin snapchat;
// //   SnapchatUser user;
// //
// //   String stickerPath;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     snapchat = SnapchatPlugin();
// //     initSnapchat();
// //   }
// //
// //   Future<void> initSnapchat() async {
// //     // Load asset to local file
// //     var d = await getTemporaryDirectory();
// //     stickerPath = p.join(d.path, "example_sticker.png");
// //     ByteData data = await rootBundle.load("assets/example_sticker.png");
// //     List<int> bytes =
// //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// //     await File(stickerPath).writeAsBytes(bytes);
// //
// //     // Init snapchat plugin
// //     await snapchat.init();
// //     SnapchatUser res = await snapchat.login();
// //     setState(() {
// //       user = res;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Plugin example app'),
// //         ),
// //         body: user == null
// //             ? Center(child: Text("User not loaded"))
// //             : Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Center(
// //               child: CircleAvatar(
// //                 child: Image.network(user.bitmoji),
// //               ),
// //             ),
// //             Center(
// //               child: Text('User: ${user.displayName}\n${user.id}'),
// //             ),
// //           ],
// //         ),
// //         floatingActionButton: FloatingActionButton(onPressed: () async {
// //           await snapchat.send(
// //             SnapMediaType.Live,
// //             sticker: SnapchatSticker(
// //               stickerPath,
// //               x: 0.5,
// //               y: 0.5,
// //               rotation: 30,
// //             ),
// //             attachment: "https://google.com",
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }
