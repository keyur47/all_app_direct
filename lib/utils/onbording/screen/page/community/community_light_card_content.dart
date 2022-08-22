import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:all_app_direct/utils/onbording/screen/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CommunityLightCardContent extends StatelessWidget {
  const CommunityLightCardContent();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPath.whatsapplogo);
  }
}