import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
