
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/edit-task/views/edit_task_view.dart';

class EditTaskButtonSection extends StatelessWidget {
  const EditTaskButtonSection({
    super.key,
    required this.widget,
    required this.isCompleted,
    required this.dayNotifier,
    required this.priorityNotifier,
    required this.title,
    required this.subTitle,
  });

  final EditTaskViewBody widget;
  final bool isCompleted;
  final ValueNotifier<DateTime> dayNotifier;
  final ValueNotifier<int> priorityNotifier;
  final TextEditingController title;
  final TextEditingController subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool isChange = false;
        if (widget.taskModel.isCompleted != isCompleted) {
          widget.taskModel.isCompleted = isCompleted;
          isChange = true;
        }
        if (widget.taskModel.dateTime != dayNotifier.value) {
          widget.taskModel.dateTime = dayNotifier.value;
    
          isChange = true;
        }
        if (widget.taskModel.priority != priorityNotifier.value) {
          widget.taskModel.priority = priorityNotifier.value;
    
          isChange = true;
        }
        if (widget.taskModel.title != title.text) {
          widget.taskModel.title = title.text;
          isChange = true;
        }
        if (widget.taskModel.description != subTitle.text) {
          widget.taskModel.description = subTitle.text;
          isChange = true;
        }
        if (isChange) {
          await TaskFirebaseOperation.updateTask(
            widget.taskModel.id!,
            widget.taskModel,
          );
        }
        Navigator.pop(context);
      },
      child: CustomButton(
        title: 'Edit Task',
        style: AppStyles.latoBold20.copyWith(
          color: AppColors.scaffoldColor,
        ),
      ),
    );
  }
}