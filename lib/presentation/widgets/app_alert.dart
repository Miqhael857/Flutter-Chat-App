
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/extensions/string_extensions.dart';
import 'package:flutter_chat_app/presentation/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_text.dart';

void showErrorDialog({required context, required msg, Widget? child}) {
  showDialog(
    context: context,
    builder: (context) {
      return child ??
          AppAlertDialog(
            text: '$msg',
            success: false,
            onTap: Navigator.of(context).pop,
          );
    },
  );
}

void showSuccessDialog({
  required context,
  required String text,
  required VoidCallback onTap,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AppAlertDialog(
        text: text,
        success: true,
        onTap: onTap,
      );
    },
  );
}

class AppAlertDialog extends AlertDialog {
  AppAlertDialog(
      {Key? key,
      required String text,
      required bool success,
      required VoidCallback onTap})
      : super(
          key: key,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 24.h,
          ),
          title: SvgPicture.asset(
            (success ? 'success' : 'alert').svg,
            width: 56.w,
          ),
          content: AppText(
             text : text,
            textAlign: TextAlign.center,
            fontSize: 12,
          ),
          actionsOverflowButtonSpacing: 24.h,
          actions: [
            AppButton(
              text: 'Okay',
              // textColor: AppColors.primary,
              onTap: onTap,
            )
          ],
        );
}
