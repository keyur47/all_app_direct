import 'package:flutter_share/flutter_share.dart';

Future Share() {
  return FlutterShare.share(
      title: "Direct WhatsApp", linkUrl: "https://play.google.com/store/games");
}
