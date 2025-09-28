import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/functions/validator.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tasky/features/auth/presentation/manager/auth_state.dart';
import 'package:tasky/features/auth/presentation/views/login_view.dart';
import 'package:tasky/features/auth/presentation/views/widgets/custom_check_auth.dart';
import 'package:tasky/features/auth/presentation/views/widgets/text_form_field_helper.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController username = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    username.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: AppStyles.latoBold32.copyWith(
                  color: AppColors.titleColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "UserName",
                style: AppStyles.latoRegular20.copyWith(
                  color: Color(0xff27282F),
                ),
              ),
              SizedBox(height: 10),
              TextFormFieldHelper(
                controller: username,
                onValidate: Validator.validateName,
                hint: "enter yout name...",
                //  onChanged: (email) {},
                isMobile: true,
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              Text(
                "Confirm password",
                style: AppStyles.latoRegular20.copyWith(
                  color: Color(0xff27282F),
                ),
              ),
              SizedBox(height: 10),
              TextFormFieldHelper(
                onValidate: (value) => Validator.validateConfirmPassword(
                  value,
                  confirmPassword.text,
                ),
                controller: confirmPassword,
                hint: "confirm password...",
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
                    ).checkSignin(email.text, password.text, username.text);
                  }
                },
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessAuthState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Success sign Up"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
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
                    return const CustomButton(title: "Sign Up");
                  },
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Center(
                      child: CustomCheckAuth(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return LoginView();
                                  },
                            ),
                          );
                        },
                        title: "Already have an account? ",
                        subTitle: "Login",
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
