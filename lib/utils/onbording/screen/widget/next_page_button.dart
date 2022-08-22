import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:flutter/material.dart';


class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding:  EdgeInsets.all(kPaddingM),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: kDarkBlue,
      onPressed: onPressed,
      child: const Icon(
        Icons.arrow_forward,
        color: kWhite,
        size: 32.0,
      ),
    );
  }
}