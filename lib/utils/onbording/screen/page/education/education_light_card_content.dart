import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:all_app_direct/utils/onbording/screen/widget/icon_container.dart';
import 'package:flutter/material.dart';


class EducationLightCardContent extends StatelessWidget {
  const EducationLightCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:   <Widget>[
        IconContainer(
          icon: Icons.brush,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.camera_alt,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.straighten,
          padding: kPaddingS,
        ),
      ],
    );
  }
}