import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/custom_drop_down.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/empty_tasks_view_body.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/task_shimmer_loading.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/tasks_loaded_body.dart';
import 'package:tasky/features/auth/presentation/widgets/text_form_field_helper.dart';

class TaskViewBody extends StatefulWidget {
  const TaskViewBody({super.key});

  @override
  State<TaskViewBody> createState() => _TaskViewBodyState();
}

class _TaskViewBodyState extends State<TaskViewBody> {
  String queryData = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
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
            const SizedBox(height: 15),
            TextFormFieldHelper(
              onChanged: (query) {
                setState(() {
                  queryData = query ?? '';
                });
              },
              hint: 'Search for your task...',
              prefixIcon: Image.asset(Assets.iconsSearchIcon),
              isMobile: true,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 20),

            /// 🔥 StreamBuilder should take remaining space
            Expanded(
              child: StreamBuilder<List<TaskModel>>(
                stream: TaskFirebaseOperation.searchTasks(queryData),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const TaskShimmerLoading();
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final tasks = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const CustomDropdown(),
                        const SizedBox(height: 20),

                        /// 👇 ListView must be wrapped in Expanded inside Column
                        Expanded(child: TasksLoadedBody(tasks: tasks)),
                      ],
                    );
                  } else {
                    return const EmptyTasksViewBody();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
