


import 'package:flutter_chat_app/domain/enitities/export.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class GetUpdateUserUseCase {
  final FirebaseRepository repository;

  GetUpdateUserUseCase({required this.repository});
  Future<void> call(UserEntity user) {
    return repository.getUpdateUser(user);
  }
}