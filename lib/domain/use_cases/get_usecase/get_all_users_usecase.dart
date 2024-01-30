
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class GetAllUsersUseCase {
  final FirebaseRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUser();
  }
}