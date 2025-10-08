import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';

class DescriptionCustomTextField extends StatelessWidget {
  const DescriptionCustomTextField({
    super.key,
    required this.priorityValueNotifier,
    required this.dayValueNotifier,
    this.controller,
    this.isLast,
    this.action,
  });
  final ValueNotifier<int> priorityValueNotifier;
  final ValueNotifier<DateTime> dayValueNotifier;
  final TextEditingController? controller;
  final TextInputAction? action;
  final bool? isLast;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      readOnly: false,
      textInputAction: isLast == true
          ? TextInputAction.done
          : TextInputAction.next,

      controller: controller,
      maxLines: 2,
      maxLength: 150,
      decoration: InputDecoration(
        suffixIcon: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor,
              ),
              child: ValueListenableBuilder(
                valueListenable: dayValueNotifier,
                builder: (context, value, child) {
                  return Text(
                    '${value.day}/${value.month}',
                    style: AppStyles.latoRegular16.copyWith(
                      color: AppColors.scaffoldColor,
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.titleColor, width: 1),
                borderRadius: BorderRadius.circular(5),
                color: AppColors.scaffoldColor,
              ),
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Image.asset(Assets.iconsPriorityIcon),
                  ValueListenableBuilder(
                    valueListenable: priorityValueNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hint: Text(
          'Description',
          style: AppStyles.latoRegular16.copyWith(
            color: AppColors.subTitleColor,
          ),
        ),

        filled: true,
        fillColor: AppColors.scaffoldColor,
      ),
    );
  }
}
