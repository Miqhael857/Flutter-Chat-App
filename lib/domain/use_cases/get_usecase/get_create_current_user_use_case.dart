import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';


class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}