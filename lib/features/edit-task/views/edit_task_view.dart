// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/show_date_dialog.dart';
import 'package:tasky/core/widgets/show_priority_dialog.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';

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

class EditTaskViewBody extends StatefulWidget {
  const EditTaskViewBody({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<EditTaskViewBody> createState() => _EditTaskViewBodyState();
}

class _EditTaskViewBodyState extends State<EditTaskViewBody> {
  late bool isCompleted;
  late ValueNotifier<DateTime> dayNotifier;
  late ValueNotifier<int> priorityNotifier;

  @override
  void initState() {
    dayNotifier = ValueNotifier(widget.taskModel.dateTime!);
    priorityNotifier = ValueNotifier(widget.taskModel.priority!);
    isCompleted = widget.taskModel.isCompleted;
    super.initState();
  }

  @override
  void dispose() {
    priorityNotifier.dispose();
    dayNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                Assets.iconsCloseIcon,
                height: 48,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 30),
            Row(
              spacing: 20,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.titleColor, width: 2),
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.scaffoldColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCompleted = !isCompleted;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isCompleted
                            ? AppColors.primaryColor
                            : AppColors.scaffoldColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        widget.taskModel.title ?? '',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      Text(
                        '${widget.taskModel.description}                                 ',
                        style: AppStyles.latoRegular18.copyWith(
                          color: AppColors.subTitleColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    Assets.iconsEditIcon,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            InfoType(
              isDate: true,
              onTap: () async {
                await pickDate(context, dayNotifier);
              },
              icon: Assets.iconsTimerIcon,
              type: 'Task Time :',
              notifier: dayNotifier,
            ),
            SizedBox(height: 30),
            InfoType(
              isDate: false,
              onTap: () async {
                await showDialog(
                  context: context,
                  barrierColor: Colors.black54,
                  builder: (context) =>
                      ShowPriorityDialog(priorityNotifier: priorityNotifier),
                );
              },
              icon: Assets.iconsPriorityIcon,
              type: 'Task Priority :',
              notifier: priorityNotifier,
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                await TaskFirebaseOperation.deleteTask(widget.taskModel.id!);
                Navigator.pop(context);
              },
              child: Row(
                spacing: 20,
                children: [
                  Image.asset(
                    Assets.iconsDeleteIcon,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'Delete Task',
                    style: AppStyles.latoRegular20.copyWith(
                      color: Color(0xffFF4949),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () async {
                widget.taskModel.isCompleted = isCompleted;
                widget.taskModel.dateTime = dayNotifier.value;
                widget.taskModel.priority = priorityNotifier.value;
                await TaskFirebaseOperation.updateTask(
                  widget.taskModel.id!,
                  widget.taskModel,
                );
                Navigator.pop(context);
              },
              child: CustomButton(
                title: 'Edit Task',
                style: AppStyles.latoBold20.copyWith(
                  color: AppColors.scaffoldColor,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class InfoType extends StatelessWidget {
  const InfoType({
    super.key,
    required this.notifier,
    required this.type,
    required this.icon,
    this.onTap,
    required this.isDate,
  });

  final ValueNotifier<dynamic> notifier;
  final String type;
  final String icon;
  final bool isDate;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsGeometry.zero,
      leading: Image.asset(icon),
      title: Text(
        type,
        style: AppStyles.latoBold20.copyWith(color: AppColors.titleColor),
      ),
      trailing: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.sizeOf(context).width * 0.2,

          decoration: BoxDecoration(
            color: Color(0xffE0DFE3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) {
              return Text(
                isDate ? '${value.day}/${value.month}' : value.toString(),
                style: AppStyles.latoRegular18.copyWith(
                  color: AppColors.titleColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
