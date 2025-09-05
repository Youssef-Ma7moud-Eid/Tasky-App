import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/auth/widgets/text_form_field_helper.dart';

class AddTaskButtonSheet extends StatefulWidget {
  const AddTaskButtonSheet({super.key});

  @override
  State<AddTaskButtonSheet> createState() => _AddTaskButtonSheetState();
}

class _AddTaskButtonSheetState extends State<AddTaskButtonSheet> {
  var today = DateTime.now();
  int taskPriority = 1;
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
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
                        hint: "Enter task title",
                        isMobile: true,
                        onChanged: (titleData) {},
                        borderRadius: BorderRadius.circular(5),
                      ),

                      SizedBox(height: 10),
                      TextField(
                        onChanged: (descriptionData) {},
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hint: Text(
                            'Description',
                            style: AppStyles.latoRegular16.copyWith(
                              color: AppColors.subTitleColor,
                            ),
                          ),

                          filled: true,
                          fillColor: AppColors.scaffoldColor,
                        ),
                      ),

                      SizedBox(height: 25),
                      Row(
                        spacing: 15,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: '',
                                barrierColor: Colors.black54, // background dim
                                transitionDuration: const Duration(
                                  milliseconds: 600,
                                ),
                                pageBuilder: (context, anim1, anim2) {
                                  return const SizedBox.shrink(); // required but unused
                                },
                                transitionBuilder: (context, anim1, anim2, child) {
                                  final curvedValue = Curves.easeInOutBack
                                      .transform(anim1.value);
                                  return Transform.scale(
                                    scale: curvedValue,
                                    child: StatefulBuilder(
                                      builder: (context, setStateDialog) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          insetPadding: const EdgeInsets.all(
                                            16,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TableCalendar(
                                                  selectedDayPredicate: (day) {
                                                    return isSameDay(
                                                      day,
                                                      today,
                                                    );
                                                  },
                                                  onDaySelected:
                                                      (
                                                        selectedDay,
                                                        focusedDay,
                                                      ) {
                                                        setStateDialog(() {
                                                          today = selectedDay;
                                                        });
                                                      },
                                                  availableGestures:
                                                      AvailableGestures.all,
                                                  headerStyle: HeaderStyle(
                                                    formatButtonVisible: false,
                                                    titleCentered: true,
                                                  ),
                                                  focusedDay: today,
                                                  firstDay: DateTime(
                                                    today.year,
                                                    today.month,
                                                    1,
                                                  ),
                                                  lastDay: DateTime(
                                                    today.year,
                                                    today.month + 12,
                                                    0,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  spacing: 10,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                        child: CustomButton(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),
                                                          title: "Cancel",
                                                          style: AppStyles
                                                              .latoRegular16
                                                              .copyWith(
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                          color: Color(
                                                            0xffFFFFFF,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: CustomButton(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),

                                                          title: "Save",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(Assets.iconsTimerIcon),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                barrierColor: Colors.black54, // background dim

                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setStateDialog) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        insetPadding: const EdgeInsets.all(16),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            spacing: 10,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Task Priority',
                                                style: AppStyles.latoBold20
                                                    .copyWith(
                                                      color:
                                                          AppColors.titleColor,
                                                    ),
                                              ),
                                              Divider(
                                                color: AppColors.subTitleColor,
                                                height: 10,
                                                thickness: 1.5,
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(
                                                      context,
                                                    ).height *
                                                    0.3,
                                                child: GridView.builder(
                                                  itemCount: 12,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10,
                                                      ),
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        taskPriority !=
                                                                index + 1
                                                            ? setStateDialog(
                                                                () {
                                                                  taskPriority =
                                                                      index + 1;
                                                                },
                                                              )
                                                            : null;
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              index + 1 !=
                                                                  taskPriority
                                                              ? AppColors
                                                                    .scaffoldColor
                                                              : AppColors
                                                                    .primaryColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              Assets
                                                                  .iconsPriorityIcon,
                                                              color:
                                                                  index + 1 ==
                                                                      taskPriority
                                                                  ? AppColors
                                                                        .scaffoldColor
                                                                  : null,
                                                            ),
                                                            const SizedBox(
                                                              height: 6,
                                                            ),
                                                            Text(
                                                              (index + 1)
                                                                  .toString(),
                                                              style: AppStyles
                                                                  .latoRegular16
                                                                  .copyWith(
                                                                    color: AppColors
                                                                        .titleColor,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Row(
                                                spacing: 10,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: CustomButton(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                        title: "Cancel",
                                                        style: AppStyles
                                                            .latoRegular16
                                                            .copyWith(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                        color: Color(
                                                          0xffFFFFFF,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: CustomButton(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),

                                                        title: "Save",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Image.asset(Assets.iconsPriorityIcon),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(Assets.iconsSendIcon),
                          ),
                        ],
                      ),
                    ],
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
