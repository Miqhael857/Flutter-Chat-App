import 'package:flutter_chat_app/data/model/chat_messages_model.dart';

abstract class MyGroupState {}

class MyGroupInitialState extends MyGroupState {}

class MyGroupLoadingState extends MyGroupState {
  final bool isLoading;

  MyGroupLoadingState({required this.isLoading});
}

class MyGroupSuccessfulState extends MyGroupState {
  final List<ChatMessagesModel> chatMessages;

  MyGroupSuccessfulState({required this.chatMessages});
}

class MyGroupFailureState extends MyGroupState {
  final String errorMessage;

  MyGroupFailureState(this.errorMessage);
}
