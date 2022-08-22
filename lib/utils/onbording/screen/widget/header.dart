
import 'package:all_app_direct/utils/onbording/constants.dart';
import 'package:all_app_direct/utils/onbording/widgets.dart';
import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         Logo(
          color: kBlack,
          size: 22.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: kBlack,
            ),
          ),
        ),
      ],
    );
  }
}