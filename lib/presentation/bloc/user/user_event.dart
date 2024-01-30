import 'package:flutter_chat_app/domain/enitities/export.dart';

abstract class UserEvent {
  const UserEvent();
}

class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  const UpdateUserEvent(this.user);
}


class DeleteUserEvent extends UserEvent {
  final String uid;
  const DeleteUserEvent(this.uid);
}


class GetUsersEvent extends UserEvent {}

