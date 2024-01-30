import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase {
  final FirebaseRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(
    String receiverId, String message) async {
    return await repository.sendTextMessage(receiverId, message);
  }
}
