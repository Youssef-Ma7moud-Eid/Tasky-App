import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomCheckAuth extends StatelessWidget {
  const CustomCheckAuth({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final String title, subTitle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$title    ', // default style
        style: AppStyles.latoRegular14.copyWith(color: AppColors.titleColor),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: subTitle,
            style: AppStyles.latoRegular14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
