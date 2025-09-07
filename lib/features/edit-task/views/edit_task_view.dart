import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/core/widgets/custom_button.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: EditTaskViewBody(),
    );
  }
}

class EditTaskViewBody extends StatelessWidget {
  const EditTaskViewBody({super.key});

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
                    Text(
                      'Today At 16:45                                 ',
                      style: AppStyles.latoRegular18.copyWith(
                        color: AppColors.subTitleColor,
                      ),
                    ),
                  ],
                ),
                Image.asset(Assets.iconsEditIcon, height: 30, fit: BoxFit.fill),
              ],
            ),
            SizedBox(height: 50),
            InfoType(
              icon: Assets.iconsTimerIcon,
              type: 'Task Time :',
              infoType: 'Today',
            ),
            SizedBox(height: 30),
            InfoType(
              icon: Assets.iconsPriorityIcon,
              type: 'Task Priority :',
              infoType: 'Default',
            ),
            SizedBox(height: 50),
            Row(
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
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {},
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
    required this.type,
    required this.infoType,
    required this.icon,
  });
  final String type;
  final String infoType;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsGeometry.zero,
      leading: Image.asset(icon),
      title: Text(
        type,
        style: AppStyles.latoBold20.copyWith(color: AppColors.titleColor),
      ),
      trailing: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.2,

        decoration: BoxDecoration(
          color: Color(0xffE0DFE3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          infoType,
          style: AppStyles.latoRegular18.copyWith(color: AppColors.titleColor),
        ),
      ),
    );
  }
}
