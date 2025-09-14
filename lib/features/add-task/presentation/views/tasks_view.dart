import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/add-task/presentation/views/task_analsis_view.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/add_task_button_sheet.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: AppColors.scaffoldColor,
      body: TaskViewBody(),

      floatingActionButton: 
      Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "graphBtn",
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskAnalysisView()),
              );
            },
            child: const Icon(Icons.bar_chart),
          ),
          AddTaskButtonSheet(),
        ],
      ),
    );
  }
}




