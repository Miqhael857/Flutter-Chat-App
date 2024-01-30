import 'package:flutter_chat_app/domain/enitities/export.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {
  final bool isLoading;

  UserLoadingState({required this.isLoading});
}

class UserSuccessfulState extends UserState {
  final List<UserEntity> users;

  UserSuccessfulState({required this.users});
}

class UserFailureState extends UserState {
  final String errorMessage;

  UserFailureState(this.errorMessage);
}
