import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/cache_helper.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/add-task/data/local-dataBase/task_local_database_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/empty_tasks_view_body.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/task_shimmer_loading.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/tasks_loaded_body.dart';
import 'package:tasky/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tasky/features/auth/presentation/manager/auth_state.dart';
import 'package:tasky/features/auth/presentation/views/login_view.dart';
import 'package:tasky/features/auth/presentation/views/widgets/text_form_field_helper.dart';

class TaskViewBody extends StatefulWidget {
  const TaskViewBody({super.key});

  @override
  State<TaskViewBody> createState() => _TaskViewBodyState();
}

class _TaskViewBodyState extends State<TaskViewBody> {
  String queryData = '';
  String selectedValue = "Today";
  final List<String> options = ["All", "Today", "Tomorrow"];
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Assets.imagesLogo, height: 40, fit: BoxFit.fill),
                  GestureDetector(
                    onTap: () async {
                      await AuthCubit.get(context).logout();
                      await CacheHelper().saveData(key: 'Login', value: false);
                    },
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogoutFauilreState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (state is LogoutSuccessState) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginView(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LogoutLoadingState) {
                          return const SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
                            ),
                          );
                        }
                        return Image.asset(
                          Assets.iconsLogoutIcon,
                          height: 28,
                          fit: BoxFit.fill,
                        );
                      },
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

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.subTitleColor,
                    width: 1.5,
                  ),
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
                    style: AppStyles.latoRegular16.copyWith(
                      color: AppColors.titleColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: StreamBuilder<List<TaskModel>>(
                  stream: TaskLocalDatabaseOperation.searchTasks(
                    queryData,
                    selectedValue,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final tasks = snapshot.data!;
                      return TasksLoadedBody(tasks: tasks);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return TaskShimmerLoading();
                    } else {
                      return const EmptyTasksViewBody();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
