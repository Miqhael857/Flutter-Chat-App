import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class GetCurrentUIDUseCase {
  final FirebaseRepository repository;

  GetCurrentUIDUseCase({required this.repository});

  Future<String> call() async{
    return repository.getCurrentUId();
  }
}
