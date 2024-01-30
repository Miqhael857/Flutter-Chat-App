import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:flutter_chat_app/presentation/screen/chats/widget/chat_bubble.dart';
import 'package:flutter_chat_app/presentation/widgets/app_alert.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text_form_field.dart';
import 'package:flutter_chat_app/presentation/widgets/utils/loaders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final String? receiverUserName;
  final String? receiverUserID;
  const ChatPage({super.key, this.receiverUserName, this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String messageContent = "";
  final _messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final ScrollController _scrollController = ScrollController();

  File? _image;
  final picker = ImagePicker();
  late String _photoUrl;

  final focusNode = FocusNode();

  String? replyMessage;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: widget.receiverUserName!,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0.h, 0.w, 12.w),
                  child: AppTextFormField(
                    height: 60,
                    controller: _messageController,
                    hintText: 'Enter Message',
                    obscureText: false,
                  ),
                ),
              ),
              Gap(10.w),
              IconButton(
                onPressed: () {
                  BlocProvider.of<ChatBloc>(context).add(
                    SendMessageEvent(
                      widget.receiverUserID!,
                      _messageController.text,
                    ),
                  );
                  _messageController.clear();
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 40.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: BlocProvider.of<ChatBloc>(context)
          .getMessageUseCase(widget.receiverUserID!, auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          showLoader();
        } else if (snapshot.hasError) {
          hideLoader();
          showErrorDialog(context: context, msg: snapshot.error);
        } else {
          List<DocumentSnapshot> messages = snapshot.data!.docs;
          return ListView(
            children:
                messages.map((message) => _buildMessageItem(message)).toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == auth.currentUser!.uid;

    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            AppText(text: data['senderEmail']),
            ChatBubble(
              isCurrentUser: isCurrentUser,
              message: data['message'],
            )
          ],
        ),
      ),
    );
  }
}
