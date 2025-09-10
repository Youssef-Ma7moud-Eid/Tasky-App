import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/bloc_observer/bloc_observer.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/add-task/presentation/manager/get_tasks_cubit.dart';
import 'package:tasky/features/onboarding/views/onboarding_view.dart';
import 'package:tasky/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTasksCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const CustomSplashScreen(),
      ),
    );
  }
}

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    const text = "Tasky";

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(text.length, (index) {
            final letter = text[index];
            final isLast = index == text.length - 1;

            return index.isEven
                ? FadeOutUp(
                    onFinish: (data) {
                      if (isLast) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                                  return OnboardingView();
                                },
                          ),
                        );
                      }
                    },
                    delay: Duration(milliseconds: 400 * index),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 55,
                        color: isLast ? const Color(0xffF5F876) : Colors.white,
                      ),
                    ),
                  )
                : FadeOutDown(
                    delay: Duration(milliseconds: 400 * index),
                    duration: const Duration(milliseconds: 600),

                    child: Text(
                      letter,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 55,
                        color: isLast ? const Color(0xffF5F876) : Colors.white,
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
