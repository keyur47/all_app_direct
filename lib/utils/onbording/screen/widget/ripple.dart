import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:flutter/material.dart';


class Ripple extends StatelessWidget {
  final double radius;

  const Ripple({
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: 2 * kPaddingL - radius,
      child: Container(
        width: 0 * radius,
        height: 2 * radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kBlack,
        ),
      ),
    );
  }
}