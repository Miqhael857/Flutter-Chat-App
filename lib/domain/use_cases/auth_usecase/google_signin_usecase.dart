import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class GoogleSignInUseCase{

  final FirebaseRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<void> call() {
    return repository.googleAuth();
  }
}