import 'package:flutter/material.dart';
import 'package:tasky/core/functions/validator.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/description_custom_textfield.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/task_detail_info.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';

class AddTaskButtonSheet extends StatefulWidget {
  const AddTaskButtonSheet({super.key});

  @override
  State<AddTaskButtonSheet> createState() => _AddTaskButtonSheetState();
}

class _AddTaskButtonSheetState extends State<AddTaskButtonSheet> {
  late final ValueNotifier<DateTime> _dayNotifier;
  late final ValueNotifier<int> _priorityNotifier;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dayNotifier = ValueNotifier<DateTime>(DateTime.now());
    _priorityNotifier = ValueNotifier<int>(1);
  }

  @override
  void dispose() {
    title.dispose();
    subTitle.dispose();
    _dayNotifier.dispose();
    _priorityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          sheetAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 700),
            reverseDuration: Duration(milliseconds: 800),
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeInOutCubic,
          ),
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          backgroundColor: AppColors.scaffoldColor,
          builder: (context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 15,
                    bottom: MediaQuery.viewInsetsOf(context).bottom,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Task',
                            style: AppStyles.latoBold20.copyWith(
                              color: AppColors.titleColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormFieldHelper(
                            controller: title,
                            hint: "Enter task title",
                            isMobile: true,
                            onValidate: Validator.validateName,
                            borderRadius: BorderRadius.circular(5),
                          ),

                          SizedBox(height: 10),
                          DescriptionCustomTextField(
                            
                            controller: subTitle,
                            dayValueNotifier: _dayNotifier,
                            priorityValueNotifier: _priorityNotifier,
                          ),

                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TaskDetailInfo(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  await TaskFirebaseOperation.addTask(
                                    TaskModel(
                                      title: title.text,
                                      dateTime: _dayNotifier.value,
                                      description: subTitle.text,
                                      priority: _priorityNotifier.value,
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              dayNotifier: _dayNotifier,
                              priorityNotifier: _priorityNotifier,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      backgroundColor: AppColors.addIconBackgroundColor,
      shape: CircleBorder(),
      child: Image.asset(Assets.iconsAddIcon),
    );
  }
}
