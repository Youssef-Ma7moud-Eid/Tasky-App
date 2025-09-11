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
    this.isLoading = false,
  });

  final String title;
  final Color? color;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : SizedBox.shrink(),
          Text(
            title,
            style:
                style ??
                AppStyles.latoSemiBold16.copyWith(
                  color: const Color(0xffFFFFFF),
                ),
          ),
        ],
      ),
    );
  }
}
