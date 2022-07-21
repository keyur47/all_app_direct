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
