import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/add-task/data/local-dataBase/task_local_database_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/task_charts.dart';

class TaskAnalysisView extends StatefulWidget {
  const TaskAnalysisView({super.key});

  @override
  State<TaskAnalysisView> createState() => _TaskAnalysisViewState();
}

class _TaskAnalysisViewState extends State<TaskAnalysisView> {
  late final Stream<List<TaskModel>> taskStream;

  @override
  void initState() {
    super.initState();
    taskStream = TaskLocalDatabaseOperation.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Task Analysis',style: AppStyles.latoBold20.copyWith(fontSize: 25)),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: taskStream,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }

          final tasks = snap.data ?? [];
          return TaskCharts(tasks: tasks);
        },
      ),
    );
  }
}
