import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessagesEntity {
  String senderId;
  String senderEmail;
  String receiverId;
  String message;
  Timestamp timestamp;

  ChatMessagesEntity({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}
