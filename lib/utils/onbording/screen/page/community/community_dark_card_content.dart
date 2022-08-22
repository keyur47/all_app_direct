import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';


class CommunityDarkCardContent extends StatelessWidget {
  const CommunityDarkCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.only(top: kPaddingL),
          child: Icon(
            Icons.whatsapp,
            color: kWhite,
            size: 32.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kPaddingL),
          child: Icon(
            BootstrapIcons.instagram,
            color: kWhite,
            size: 32.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: kPaddingL),
          child: Icon(
            Icons.telegram,
            color: kWhite,
            size: 32.0,
          ),
        ),
      ],
    );
  }
}