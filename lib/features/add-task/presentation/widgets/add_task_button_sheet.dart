import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/presentation/widgets/description_custom_textfield.dart';
import 'package:tasky/features/add-task/presentation/widgets/task_detail_info.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';

class AddTaskButtonSheet extends StatefulWidget {
  const AddTaskButtonSheet({super.key});

  @override
  State<AddTaskButtonSheet> createState() => _AddTaskButtonSheetState();
}

class _AddTaskButtonSheetState extends State<AddTaskButtonSheet> {
  late final ValueNotifier<DateTime> _dayNotifier;
  late final ValueNotifier<int> _priorityNotifier;
  String? title = '';
  String? subTitle = '';
  @override
  void initState() {
    super.initState();
    _dayNotifier = ValueNotifier<DateTime>(DateTime.now());
    _priorityNotifier = ValueNotifier<int>(1);
  }

  @override
  void dispose() {
    _dayNotifier.dispose();
    _priorityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          sheetAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 700),
            reverseDuration: Duration(milliseconds: 800),
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeInOutCubic,
          ),
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          backgroundColor: AppColors.scaffoldColor,
          builder: (context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 15,
                    bottom: MediaQuery.viewInsetsOf(context).bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Task',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormFieldHelper(
                        hint: "Enter task title",
                        isMobile: true,
                        onChanged: (titleData) {
                          title = titleData;
                        },
                        borderRadius: BorderRadius.circular(5),
                      ),

                      SizedBox(height: 10),
                      DescriptionCustomTextField(
                        onChanged: (description) {
                          subTitle = description;
                        },
                        dayValueNotifier: _dayNotifier,
                        priorityValueNotifier: _priorityNotifier,
                      ),

                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TaskDetailInfo(
                          onTap: () {
                            log(title!);
                            log(subTitle!);
                            log(_dayNotifier.value.toString());
                            log(_priorityNotifier.value.toString());

                            Navigator.pop(context);
                          },
                          dayNotifier: _dayNotifier,
                          priorityNotifier: _priorityNotifier,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      backgroundColor: AppColors.addIconBackgroundColor,
      shape: CircleBorder(),
      child: Image.asset(Assets.iconsAddIcon),
    );
  }
}
