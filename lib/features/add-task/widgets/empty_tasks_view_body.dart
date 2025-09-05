import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';

class EmptyTasksViewBody extends StatelessWidget {
  const EmptyTasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.imagesLogo, height: 40, fit: BoxFit.fill),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    Assets.iconsLogoutIcon,
                    height: 28,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.37,
              width: MediaQuery.sizeOf(context).width * 0.98,
              child: Image.asset(Assets.imagesEmptyTask, fit: BoxFit.fill),
            ),
            SizedBox(height: 30),
            Text(
              'What do you want to do today?',
              style: AppStyles.latoBold20.copyWith(
                color: AppColors.addIconBackgroundColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tap + to add your tasks',
              style: AppStyles.latoRegular16.copyWith(
                color: AppColors.addIconBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
