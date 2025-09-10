import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/core/widgets/show_date_dialog.dart';
import 'package:tasky/core/widgets/show_priority_dialog.dart';

class TaskDetailInfo extends StatefulWidget {
  const TaskDetailInfo({
    super.key,
    required this.dayNotifier,
    required this.priorityNotifier,
    this.onTap,
  });

  final ValueNotifier<DateTime> dayNotifier;
  final ValueNotifier<int> priorityNotifier;
  final void Function()? onTap;

  @override
  State<TaskDetailInfo> createState() => _TaskDetailInfoState();
}

class _TaskDetailInfoState extends State<TaskDetailInfo> {
 

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        GestureDetector(
          onTap: () async => await pickDateTime(context,widget.dayNotifier),
          child: Image.asset(Assets.iconsTimerIcon),
        ),
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              barrierColor: Colors.black54,
              builder: (context) =>
                  ShowPriorityDialog(priorityNotifier: widget.priorityNotifier),
            );
          },
          child: Image.asset(Assets.iconsPriorityIcon),
        ),
        const Spacer(),
        GestureDetector(
          onTap: widget.onTap,
          child: Image.asset(Assets.iconsSendIcon),
        ),
      ],
    );
  }
}
