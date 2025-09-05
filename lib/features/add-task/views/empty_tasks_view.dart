import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/widgets/empty_tasks_view_body.dart';

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyTasksViewBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.addIconBackgroundColor,
        shape: CircleBorder(),
        child: Image.asset(Assets.iconsAddIcon),
      ),
    );
  }
}

