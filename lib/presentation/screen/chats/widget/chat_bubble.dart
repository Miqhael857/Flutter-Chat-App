import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme/app_colors.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isCurrentUser ? Colors.green : Colors.grey.shade500),
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
      child: AppText(
        text: message,
        color: AppColors.whiteTextStyle,
      ),
    );
  }
}
