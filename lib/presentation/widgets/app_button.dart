import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const AppButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xFF445C64),
          borderRadius: BorderRadius.circular(4.r),
        ),
        alignment: Alignment.center,
        child: AppText(
          text: text,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  }

