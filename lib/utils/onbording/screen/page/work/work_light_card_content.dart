import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:all_app_direct/utils/onbording/screen/widget/icon_container.dart';
import 'package:flutter/material.dart';


class WorkLightCardContent extends StatelessWidget {
  const WorkLightCardContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:   <Widget>[
        IconContainer(
          icon: Icons.event_seat,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.business_center,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.assessment,
          padding: kPaddingS,
        ),
      ],
    );
  }
}