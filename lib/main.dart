import 'package:flutter/material.dart';
import 'package:tasky/features/onboarding/widgets/onboarding_view_body.dart';

void main() {
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingViewBody(),
    );
  }
}
