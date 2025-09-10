import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/edit-task/widgets/edit_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: EditTaskViewBody(taskModel: taskModel),
    );
  }
}

