import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/show_confirm_dialog.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/edit-task/widgets/edit_view_body.dart';

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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          await showConfirmationDialog(
            context: context,
            action: "Update",
            message: "Are you sure you want to update this task?",
            onConfirm: () async {
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

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task updated successfully ✅")),
                );
              }

              Navigator.pop(context);
            },
          );
        },
        child: Text(
          'Edit Task',
          style: AppStyles.latoBold20.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
