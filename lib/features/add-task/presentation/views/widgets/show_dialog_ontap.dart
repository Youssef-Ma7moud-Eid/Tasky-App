import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';

class ShowDialogOnTap extends StatelessWidget {
  const ShowDialogOnTap({
    super.key,
     this.selectedPriority,
    this.onTap,
  });

  final int ?selectedPriority;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CustomButton(
              borderRadius: BorderRadius.circular(4),
              title: "Cancel",
              style: AppStyles.latoRegular16.copyWith(
                color: AppColors.primaryColor,
              ),
              color: const Color(0xffFFFFFF),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: CustomButton(
              borderRadius: BorderRadius.circular(4),
              title: "Save",
            ),
          ),
        ),
      ],
    );
  }
}
