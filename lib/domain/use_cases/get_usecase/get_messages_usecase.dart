import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class GetMessageUseCase {
  final FirebaseRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<QuerySnapshot> call(String userId, String otherUserId) {
    return repository.getMessages(userId, otherUserId);
  }
}
