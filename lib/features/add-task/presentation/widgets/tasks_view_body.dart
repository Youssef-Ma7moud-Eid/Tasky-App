import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/presentation/widgets/custom_drop_down.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';
import 'package:tasky/features/edit-task/views/edit_task_view.dart';

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
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                                return EditTaskView();
                              },
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.subTitleColor,
                          width: 1.5,
                        ),
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
                                style: AppStyles.latoRegular20.copyWith(
                                  color: AppColors.titleColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

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
                                        width: 1.2,
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
                                          style: AppStyles.latoRegular18
                                              .copyWith(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
