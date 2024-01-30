import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/theme/app_colors.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_event.dart';
import 'package:flutter_chat_app/presentation/screen/signin/sign_in_page.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final UserEntity user = const UserEntity();

  @override
  void initState() {
    super.initState();
    userCollection.doc(auth.currentUser!.uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        nameController.text = snapshot['name'];
        emailController.text = snapshot['email'];
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteTextStyle,
      appBar: AppBar(
        backgroundColor: AppColors.whiteTextStyle,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  enabled: true,
                  child: InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      BlocProvider.of<SignOutBloc>(context)
                          .add(SignOutInitialEvent());
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignInPage()),
                      );
                    },
                    child: const Row(
                      children: [
                        Text('LogOut'),
                        Icon(Icons.logout, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.w),
                child: const AppText(text: "My Profile"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppTextFormField(
                  controller: nameController,
                  hintText: "Name",
                ),
              ),
              Gap(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              Gap(45.h),
            ],
          ),
        ),
      ),
    );
  }
}
