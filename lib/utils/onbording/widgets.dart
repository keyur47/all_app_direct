import 'dart:math';

import 'package:all_app_direct/utils/assets_path.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

// return Transform.rotate(
// angle: -pi / 4,
// child: Image.asset(AssetsPath.applicationLogo,scale: size,)
// );