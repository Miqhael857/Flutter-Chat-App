
abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final String receiverUserId;
  final String message;

  const SendMessageEvent(this.receiverUserId, this.message);
}


class GetMessageEvent extends ChatEvent {
  final String userId;
  final String otherUserId;

  const GetMessageEvent(this.userId, this.otherUserId);
}

