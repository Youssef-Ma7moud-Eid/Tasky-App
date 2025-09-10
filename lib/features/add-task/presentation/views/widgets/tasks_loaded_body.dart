import 'package:flutter/material.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/task_item.dart';
import 'package:tasky/features/edit-task/views/edit_task_view.dart';

class TasksLoadedBody extends StatelessWidget {
  const TasksLoadedBody({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((t) => t.isCompleted == true).toList();
    final uncompletedTasks =
        tasks.where((t) => t.isCompleted == false).toList();

    final combinedList = [
       {"type": "header", "title": "Uncompleted"},
      ...uncompletedTasks.map((t) => {"type": "task", "task": t}),
      {"type": "header", "title": "Completed"},
      ...completedTasks.map((t) => {"type": "task", "task": t}),
     
    ];

    return ListView.builder(
      itemCount: combinedList.length,
      itemBuilder: (context, index) {
        final item = combinedList[index];

        if (item["type"] == "header") {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Text(
              item["title"] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          final task = item["task"] as TaskModel;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => EditTaskView(taskModel: task),
                ),
              );
            },
            child: TaskItem(task: task),
          );
        }
      },
    );
  }
}


