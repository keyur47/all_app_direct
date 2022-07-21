import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(
    {required String contact, required bool direct}) async {
  if (direct == true) {
    bool? res = await FlutterPhoneDirectCaller.callNumber(contact);
  } else {
    String telScheme = 'tel:$contact';
    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Could not launch $telScheme';
    }
  }
}