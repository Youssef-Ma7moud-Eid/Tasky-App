import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.subTitleColor, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.titleColor, width: 2),
              shape: BoxShape.circle,
              color: AppColors.scaffoldColor,
            ),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted
                    ? AppColors.primaryColor
                    : AppColors.scaffoldColor,
              ),
            ),
          ),
          const SizedBox(width: 20),
    
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title ?? '',
                  style: AppStyles.latoRegular20.copyWith(
                    color: AppColors.titleColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.description ?? '',
                        style: AppStyles.latoRegular18.copyWith(
                          color: AppColors.subTitleColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.scaffoldColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.iconsPriorityIcon,
                            height: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            task.priority?.toString() ?? '',
                            style: AppStyles.latoRegular18.copyWith(
                              color: AppColors.titleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
