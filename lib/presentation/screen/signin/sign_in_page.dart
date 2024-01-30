import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_event.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_state.dart';
import 'package:flutter_chat_app/presentation/screen/signup/sign_up_page.dart';
import 'package:flutter_chat_app/presentation/widgets/app_alert.dart';
import 'package:flutter_chat_app/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:flutter_chat_app/presentation/widgets/app_button.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text_form_field.dart';
import 'package:flutter_chat_app/presentation/widgets/utils/loaders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _hidePass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
      if (state is SignInSuccessfulState) {
        hideLoader();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AppBottomNavigationBar()));
      } else if (state is SignInLoadingState) {
        showLoader();
      } else if (state is SignInFailureState) {
        hideLoader();
        showErrorDialog(context: context, msg: state.errorMessage);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: AppText(
                    text: 'Sign In',
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: AppTextFormField(
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
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: AppTextFormField(
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
                      icon: Icon(
                          _hidePass ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hidePass = !_hidePass;
                        });
                      },
                    ),
                  ),
                ),
                Gap(30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: AppButton(
                    text: 'SignIn',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<SignInBloc>(context)
                            .add(SignInInitialEvent(
                          emailController.text,
                          passwordController.text,
                        ));
                      }
                    },
                  ),
                ),
                Gap(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: 'Don\'t have an account?',
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Gap(5.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: AppText(
                        text: 'Create account',
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
