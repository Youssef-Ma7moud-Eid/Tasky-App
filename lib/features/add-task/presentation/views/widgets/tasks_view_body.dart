import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/custom_drop_down.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/empty_tasks_view_body.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';
import 'package:tasky/features/edit-task/views/edit_task_view.dart';

class TaskViewBody extends StatelessWidget {
  const TaskViewBody({super.key});
  //  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: taskStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TaskShimmerLoading();
        } else if (snapshot.hasError) {
          return Center(child: Text('something error'));
        } else if (snapshot.data!.docs.isNotEmpty) {
          List<TaskModel> tasks = snapshot.data!.docs
              .map(
                (doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList();
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
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                      return EditTaskView(
                                        taskModel: tasks[index],
                                      );
                                    },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
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
                                      tasks[index].title ?? '',
                                      style: AppStyles.latoRegular20.copyWith(
                                        color: AppColors.titleColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                              0.6,
                                          child: Text(
                                            '${tasks[index].description}' ?? '',
                                            style: AppStyles.latoRegular18
                                                .copyWith(
                                                  color:
                                                      AppColors.subTitleColor,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.all(2),
                                          alignment:
                                              AlignmentDirectional.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            color: AppColors.scaffoldColor,
                                          ),
                                          child: Row(
                                            spacing: 8,
                                            children: [
                                              Image.asset(
                                                Assets.iconsPriorityIcon,
                                              ),
                                              Text(
                                               tasks[index].priority!.toString(),
                                                style: AppStyles.latoRegular18
                                                    .copyWith(
                                                      color:
                                                          AppColors.titleColor,
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
        } else {
          return EmptyTasksViewBody();
        }
      },
    );
  }
}

class TaskShimmerLoading extends StatelessWidget {
  const TaskShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6, // عدد العناصر الوهمية
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!, width: 1.5),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey[400], radius: 15),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 180, height: 18, color: Colors.grey[400]),
                    const SizedBox(height: 10),
                    Container(width: 120, height: 16, color: Colors.grey[400]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
