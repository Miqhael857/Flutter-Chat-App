import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {
  final bool isLoading;

  ChatLoadingState({required this.isLoading});
}

class ChatSuccessfulState extends ChatState {
 QuerySnapshot<Object?> message;

  ChatSuccessfulState(this.message);
}

class ChatFailureState extends ChatState {
  final String errorMessage;

  ChatFailureState(this.errorMessage);
}
