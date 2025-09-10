import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/show_dialog_ontap.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';
import 'package:tasky/features/edit-task/widgets/delete_task_section.dart';
import 'package:tasky/features/edit-task/widgets/edit_task_button_section.dart';
import 'package:tasky/features/edit-task/widgets/info_type.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/core/widgets/show_confirm_dialog.dart';
import 'package:tasky/core/widgets/show_date_dialog.dart';
import 'package:tasky/core/widgets/show_priority_dialog.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
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
  late TextEditingController title;
  late TextEditingController subTitle;
  late GlobalKey<FormState> formkey;
  @override
  void initState() {
    formkey = GlobalKey();
    title = TextEditingController();
    subTitle = TextEditingController();
    title.text = widget.taskModel.title!;
    subTitle.text = widget.taskModel.description!;
    dayNotifier = ValueNotifier(widget.taskModel.dateTime!);
    priorityNotifier = ValueNotifier(widget.taskModel.priority!);
    isCompleted = widget.taskModel.isCompleted;
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    subTitle.dispose();
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
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        title.text,
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${subTitle.text}                                 ',
                        style: AppStyles.latoRegular18.copyWith(
                          color: AppColors.subTitleColor,
                        ),
                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom:
                                    MediaQuery.viewInsetsOf(context).bottom +
                                    MediaQuery.sizeOf(context).height * 0.03,
                              ),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Edit Task',
                                      style: AppStyles.latoBold20.copyWith(
                                        color: AppColors.titleColor,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormFieldHelper(
                                      maxLength: 50,
                                      controller: title,
                                      borderRadius: BorderRadius.circular(12),
                                      hint: "Edit title",
                                      isMobile: true,
                                    ),

                                    TextFormFieldHelper(
                                      maxLength: 150,
                                      controller: subTitle,
                                      borderRadius: BorderRadius.circular(12),
                                      maxLines: 2,
                                      hint: "Edit sub title",
                                      isMobile: true,
                                    ),
                                    SizedBox(height: 15),
                                    ShowDialogOnTap(
                                      onTap: () async {
                                        if (formkey.currentState!.validate()) {
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      },
                                      onTap2: () {
                                        title.text = widget.taskModel.title!;
                                        subTitle.text =
                                            widget.taskModel.description!;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
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
                await showConfirmationDialog(
                  context: context,
                  action: "Delete",
                  message: "Are you sure you want to delete this task?",
                  onConfirm: () async {
                    await TaskFirebaseOperation.deleteTask(
                      widget.taskModel.id!,
                    );
                    Navigator.pop(context);
                  },
                );
              },
              child: DeleteTaskSection(),
            ),
            Expanded(child: SizedBox()),
            EditTaskButtonSection(
              widget: widget,
              isCompleted: isCompleted,
              dayNotifier: dayNotifier,
              priorityNotifier: priorityNotifier,
              title: title,
              subTitle: subTitle,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
