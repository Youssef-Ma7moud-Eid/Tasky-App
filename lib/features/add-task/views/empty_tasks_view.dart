import 'package:flutter/material.dart';
import 'package:tasky/features/add-task/widgets/add_task_button_sheet.dart';
import 'package:tasky/features/add-task/widgets/empty_tasks_view_body.dart';

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyTasksViewBody(),
      floatingActionButton: AddTaskButtonSheet(),
    );
  }
}
