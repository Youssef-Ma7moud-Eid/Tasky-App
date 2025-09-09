
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: LoginViewBody(),
    );
  }
}




