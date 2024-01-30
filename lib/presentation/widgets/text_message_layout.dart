import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/reply_message_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TextMessageLayout extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final CrossAxisAlignment boxAlign;
  final Color color;
  final BubbleNip nip;
  final String? replyingMessage;
  final TextAlign alignName;
  final TextAlign align;
  final String? name;
  final String? text;
  final String time;
  final String groupId;
  final String? messageId;
  final String? replyingName;

  const TextMessageLayout({
    super.key,
    required this.crossAxisAlignment,
    required this.color,
    required this.nip,
    this.replyingMessage,
    required this.alignName,
    required this.align,
    this.name,
    this.text,
    required this.time,
    required this.boxAlign,
    required this.groupId,
    this.messageId,
    this.replyingName,
  });

  @override
  Widget build(BuildContext context) {
    Offset? tapPos;

    final replyMessage = replyingMessage != null;

    return InkWell(
      onTapDown: (TapDownDetails details) {
        tapPos = details.globalPosition;
      },
      onLongPress: () {
        _showMenu(context, tapPos!);
      },
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.50,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(3),
              child: Bubble(
                color: color,
                nip: nip,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (replyMessage) buildReplyMessage(context),
                    AppText(
                      text: name!,
                      textAlign: alignName,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText(
                        text: text!,
                        textAlign: align,
                        fontSize: 16,
                      ),
                    ),
                    AppText(
                      text: time,
                      textAlign: align,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReplyMessage(BuildContext context) {
    final replyMessage = replyingMessage;
    final isReplying = replyMessage != null;

    if (!isReplying) {
      return Container();
    } else {
      return Column(
        children: [
          ReplyMessageWidget(
            replyMessage: replyMessage,
            name: 'User',
            textAlign: alignName,
            align: align,
            crossAxisAlignment: crossAxisAlignment,
          ),
          Gap(10.h),
        ],
      );
    }
  }

  _showMenu(BuildContext context, Offset tapPos) {
    final RenderBox overlay = context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
      tapPos.dx,
      tapPos.dy,
      overlay.size.width - tapPos.dx,
      overlay.size.height - tapPos.dy,
    );
    showMenu<String>(
      context: context,
      position: position,
      items: <PopupMenuItem<String>>[
        PopupMenuItem(
          child: const Text('Delete Message'),
          onTap: () {
            // BlocProvider.of<ChatBloc>(context).add(ChatEvent.deleteTextMessage(
            //     channelId: groupId, messageId: messageId!));
          },
        ),
      ],
    );
  }
}
