

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';

class DeleteTaskSection extends StatelessWidget {
  const DeleteTaskSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

