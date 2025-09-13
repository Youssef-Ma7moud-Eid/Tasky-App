import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/functions/validator.dart';
import 'package:tasky/core/services/cache_helper.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/add-task/presentation/views/tasks_view.dart';
import 'package:tasky/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tasky/features/auth/presentation/manager/auth_state.dart';
import 'package:tasky/features/auth/presentation/views/register_view.dart';
import 'package:tasky/features/auth/presentation/views/widgets/custom_check_auth.dart';
import 'package:tasky/features/auth/presentation/views/widgets/text_form_field_helper.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool view = false;
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                'Login',
                style: AppStyles.latoBold32.copyWith(
                  color: AppColors.titleColor,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Email",
                style: AppStyles.latoRegular20.copyWith(
                  color: Color(0xff27282F),
                ),
              ),
              SizedBox(height: 10),
              TextFormFieldHelper(
                controller: email,
                onValidate: Validator.validateEmail,
                hint: "enter Email...",
                //  onChanged: (email) {},
                isMobile: true,
              ),
              SizedBox(height: 30),
              Text(
                "Password",
                style: AppStyles.latoRegular20.copyWith(
                  color: Color(0xff27282F),
                ),
              ),
              SizedBox(height: 10),
              TextFormFieldHelper(
                onValidate: Validator.validatePassword,
                controller: password,
                hint: "Password...",
                isPassword: true,
                //   onChanged: (password) {},
                isMobile: true,
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await AuthCubit.get(
                      context,
                    ).checkLogin(email.text, password.text);
                    view = true;
                  }
                },
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessAuthState && view == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Success',
                        desc: "Login successful",
                        btnOkOnPress: () async {
                          await CacheHelper().saveData(
                            key: 'Login',
                            value: true,
                          );

                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return TasksView();
                                  },
                            ),
                          );
                        },
                        dismissOnBackKeyPress: false,
                        dismissOnTouchOutside: false,
                      ).show();
                    } else if (state is FailureAuthState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingAuthState) {
                      return const CustomButton(
                        title: "Loading ..",
                        isLoading: true,
                      );
                    }
                    return const CustomButton(title: "Login");
                  },
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Center(
                      child: CustomCheckAuth(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return RegisterView();
                                  },
                            ),
                          );
                        },
                        title: "Don’t have an account?",
                        subTitle: "Register",
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
