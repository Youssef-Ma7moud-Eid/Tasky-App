import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.color,
    this.style,
    this.borderRadius,
  });
  final String title;
  final Color? color;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style:
            style ??
            AppStyles.latoSemiBold16.copyWith(color: Color(0xffFFFFFF)),
      ),
    );
  }
}
