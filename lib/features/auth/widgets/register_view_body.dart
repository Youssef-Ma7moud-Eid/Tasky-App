import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/functions/snak_bar.dart';
import 'package:tasky/core/functions/validator.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/auth/views/login_view.dart';
import 'package:tasky/features/auth/widgets/custom_check_auth.dart';
import 'package:tasky/features/auth/widgets/text_form_field_helper.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();

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
                onValidate: Validator.validatePassword,

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
                    if (Validator.validateConfirmPassword(
                          password.text,
                          confirmPassword.text,
                        ) ==
                        null) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                                  return LoginView();
                                },
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          scaffoldmessenger(
                            context: context,
                            color: AppColors.primaryColor,
                            text: 'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          scaffoldmessenger(
                            context: context,
                            color: AppColors.primaryColor,
                            text: 'The account already exists for that email.',
                          );
                        }
                      } catch (e) {
                        scaffoldmessenger(
                          context: context,
                          color: AppColors.primaryColor,
                          text: e.toString(),
                        );
                      }
                    } else {
                      scaffoldmessenger(
                        context: context,
                        color: AppColors.primaryColor,
                        text: "Password don't match",
                      );
                    }
                  }
                },
                child: CustomButton(title: "Register"),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
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
