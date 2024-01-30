import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/enitities/export.dart';
import 'package:flutter_chat_app/presentation/widgets/image_message_layout.dart';
import 'package:flutter_chat_app/presentation/widgets/text_message_layout.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

class MessagesListWidget extends StatelessWidget {
  final ScrollController controller;
  final List<TextMessageEntity> messages;
  final String userId;
  final String? name;
  final String groupId;
  final File? image;
  final ValueChanged<String> onSwipedMessage;

  const MessagesListWidget({
    super.key,
    required this.controller,
    required this.messages,
    required this.userId,
    this.name,
    required this.groupId,
    this.image,
    required this.onSwipedMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final message = messages[index];
        if (message.senderId == userId) {
          return message.type == 'TEXT'
              ? SwipeTo(
                  onLeftSwipe: (details) => onSwipedMessage(message.content!),
                  child: TextMessageLayout(
                    text: message.content,
                    time: DateFormat('hh:mm a').format(message.time!.toDate()),
                    color: Theme.of(context).cardColor,
                    align: TextAlign.left,
                    boxAlign: CrossAxisAlignment.start,
                    nip: BubbleNip.rightTop,
                    name: name ?? "${message.senderName}",
                    alignName: TextAlign.end,
                    groupId: groupId,
                    replyingMessage: message.replyingMessage,
                    messageId: message.messageId,
                    replyingName: message.senderId == userId ? 'Me' : name,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                )
              : ImageMessageLayout(
                  imageUrl: message.content!,
                  align: TextAlign.left,
                  alignName: TextAlign.end,
                  boxAlign: CrossAxisAlignment.start,
                  color: Theme.of(context).cardColor,
                  crossAlign: CrossAxisAlignment.end,
                  nip: BubbleNip.rightTop,
                  time: DateFormat('hh:mm a').format(message.time!.toDate()),
                  name: "Me",
                  image: image,
                );
        } else {
          return message.type == "TEXT"
              ? SwipeTo(
                  onLeftSwipe: (details) => onSwipedMessage(message.content!),
                  child: TextMessageLayout(
                    text: message.content,
                    time: DateFormat('hh:mm a').format(message.time!.toDate()),
                    color: Theme.of(context).cardColor,
                    align: TextAlign.left,
                    boxAlign: CrossAxisAlignment.start,
                    nip: BubbleNip.leftTop,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    name: name ?? "${message.senderName}",
                    alignName: TextAlign.end,
                    groupId: groupId,
                    replyingMessage: message.replyingMessage,
                    messageId: message.messageId,
                    replyingName:
                        userId == message.senderId ? name : message.senderName,
                  ),
                )
              : ImageMessageLayout(
                  imageUrl: message.content!,
                  align: TextAlign.left,
                  alignName: TextAlign.end,
                  boxAlign: CrossAxisAlignment.start,
                  color: Theme.of(context).cardColor,
                  crossAlign: CrossAxisAlignment.start,
                  nip: BubbleNip.leftTop,
                  time: DateFormat('hh:mm a').format(message.time!.toDate()),
                  name: name ?? "${message.senderName}",
                  image: image,
                );
        }
      },
    );
  }
}
