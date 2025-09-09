import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/widgets/show_dialog_ontap.dart';

class ShowPriorityDialog extends StatefulWidget {
  const ShowPriorityDialog({super.key, required this.priorityNotifier});
  final ValueNotifier<int> priorityNotifier;
  @override
  State<ShowPriorityDialog> createState() => _ShowPriorityDialogState();
}

class _ShowPriorityDialogState extends State<ShowPriorityDialog> {
  final List<String> priorityNums = List.generate(10, (i) => "${i + 1}");

  late int selectedPriority;
  @override
  void initState() {
    selectedPriority = widget.priorityNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      insetPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Task Priority',
              style: AppStyles.latoBold20.copyWith(color: AppColors.titleColor),
            ),
            Divider(color: AppColors.subTitleColor, height: 10, thickness: 1.5),
            Wrap(
              spacing: 25,
              runSpacing: 12,
              children: List.generate(priorityNums.length, (index) {
                final isSelected = selectedPriority == index + 1;

                return GestureDetector(
                  onTap: () {
                    selectedPriority != index + 1
                        ? setState(() {
                            selectedPriority = index + 1;
                          })
                        : null;
                  },
                  child: Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.scaffoldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.iconsPriorityIcon,
                          color: isSelected ? AppColors.scaffoldColor : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          (index + 1).toString(),
                          style: AppStyles.latoRegular16.copyWith(
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            ShowDialogOnTap(
              onTap: () {
                widget.priorityNotifier.value = selectedPriority;
                log(selectedPriority.toString());
                Navigator.pop(context, selectedPriority);
              },
              selectedPriority: selectedPriority,
            ),
          ],
        ),
      ),
    );
  }
}
