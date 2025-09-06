import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/widgets/add_task_button_sheet.dart';
import 'package:tasky/features/auth/widgets/text_form_field_helper.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: TaskViewBody(),
      floatingActionButton: AddTaskButtonSheet(),
    );
  }
}

class TaskViewBody extends StatelessWidget {
  const TaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.asset(
              Assets.imagesLogo,
              fit: BoxFit.fill,
              height: 40,
              width: 90,
            ),
            SizedBox(height: 15),
            TextFormFieldHelper(
              onChanged: (taskName) {},
              hint: 'Search for your task...',
              prefixIcon: Image.asset(Assets.iconsSearchIcon),
              isMobile: true,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(height: 40),
            CustomDropdown(),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 15,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: 13,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Do Math Homework ',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Today At 16:45                                 ',
                            style: AppStyles.latoRegular18.copyWith(
                              color: AppColors.subTitleColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.scaffoldColor,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Image.asset(Assets.iconsPriorityIcon),
                                Text(
                                  '1',
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
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Completed',
                style: AppStyles.latoRegular16.copyWith(
                  color: AppColors.titleColor,
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 15,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: 13,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Do Math Homework ',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Today At 16:45                                 ',
                            style: AppStyles.latoRegular18.copyWith(
                              color: AppColors.subTitleColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.scaffoldColor,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Image.asset(Assets.iconsPriorityIcon),
                                Text(
                                  '1',
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
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Completed',
                style: AppStyles.latoRegular16.copyWith(
                  color: AppColors.titleColor,
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 15,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: 13,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 10,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Do Math Homework ',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Today At 16:45                                 ',
                            style: AppStyles.latoRegular18.copyWith(
                              color: AppColors.subTitleColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.scaffoldColor,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Image.asset(Assets.iconsPriorityIcon),
                                Text(
                                  '1',
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
                ],
              ),
            
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.subTitleColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 15,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: 13,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 10,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text(
                        'Do Math Homework ',
                        style: AppStyles.latoBold20.copyWith(
                          color: AppColors.titleColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            'Today At 16:45                                 ',
                            style: AppStyles.latoRegular18.copyWith(
                              color: AppColors.subTitleColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.scaffoldColor,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Image.asset(Assets.iconsPriorityIcon),
                                Text(
                                  '1',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedValue = "Today";
  final List<String> options = ["Today", "Tomorrow", "Next Week"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.subTitleColor, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: Alignment.center,
          value: selectedValue,
          isDense: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
          style: AppStyles.latoRegular16.copyWith(color: AppColors.titleColor),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: options.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
