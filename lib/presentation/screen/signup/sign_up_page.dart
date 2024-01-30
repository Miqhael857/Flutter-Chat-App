import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_event.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_state.dart';
import 'package:flutter_chat_app/core/theme/app_colors.dart';
import 'package:flutter_chat_app/presentation/screen/signin/sign_in_page.dart';
import 'package:flutter_chat_app/presentation/widgets/app_alert.dart';
import 'package:flutter_chat_app/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:flutter_chat_app/presentation/widgets/app_button.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text_form_field.dart';
import 'package:flutter_chat_app/presentation/widgets/utils/loaders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _hidePass = true;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpSuccessfulState) {
        hideLoader();
        Fluttertoast.showToast(
          msg: 'Your account has been created successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.successContainer,
          textColor: AppColors.successText,
          fontSize: 16.0,
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AppBottomNavigationBar()));
      } else if (state is SignUpLoadingState) {
        showLoader();
      } else if (state is SignUpFailureState) {
        hideLoader();
        showErrorDialog(context: context, msg: state.errorMessage);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: 'Create an Account',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(30.h),
                    AppTextFormField(
                      controller: nameController,
                      hintText: "Name",
                    ),
                    Gap(30.h),
                    AppTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: "Email Address",
                      prefixIcon: Icons.mail,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The value cannot be empty';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    Gap(30.h),
                    AppTextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Icons.password,
                      obscureText: _hidePass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The value cannot be empty';
                        } else if (value.length < 6) {
                          return 'Please enter at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(_hidePass
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _hidePass = !_hidePass;
                          });
                        },
                      ),
                    ),
                    Gap(30.h),
                    AppButton(
                      text: 'SignUp',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpBloc>(context).add(
                            SignUpInitialEvent(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                    Gap(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: 'Already have an account?',
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(5.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                          },
                          child: AppText(
                            text: 'Sign in',
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
