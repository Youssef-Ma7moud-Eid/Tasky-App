import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/add-task/presentation/manager/get_tasks_cubit.dart';
import 'package:tasky/features/add-task/presentation/manager/get_tasks_state.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/add_task_button_sheet.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/empty_tasks_view_body.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: BlocBuilder<GetTasksCubit, GetTasksState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            return TaskViewBody();
          } else if (state is TasksLoading) {
           return TaskShimmerLoading();
          } else {
            return EmptyTasksViewBody();
          }
        },
      ),
      floatingActionButton: AddTaskButtonSheet(),
    );
  }
}
