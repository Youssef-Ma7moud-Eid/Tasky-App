import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';

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
