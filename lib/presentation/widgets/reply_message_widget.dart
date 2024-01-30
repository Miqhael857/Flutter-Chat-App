import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReplyMessageWidget extends StatelessWidget {
  final String replyMessage;
  final VoidCallback? onCancelReply;
  final String name;
  final TextAlign textAlign;
  final TextAlign align;
  final CrossAxisAlignment crossAxisAlignment;

  const ReplyMessageWidget(
      {Key? key,
      required this.replyMessage,
      this.onCancelReply,
      required this.name,
      required this.textAlign,
      required this.align,
      required this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                         text:  name,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (onCancelReply != null)
                        GestureDetector(
                          onTap: onCancelReply,
                          child:  Icon(Icons.close, size: 16.sp),
                        )
                    ],
                  ),
                   Gap(8.h),
                  AppText(
                   text: replyMessage.length > 20
                        ? '${replyMessage.substring(0, 20)}...'
                        : replyMessage,
                    textAlign: align,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}