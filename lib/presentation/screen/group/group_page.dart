import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AppText(
            text: "Group Page",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
