abstract class MyGroupEvent {
  const MyGroupEvent();
}

class JoinMyGroupEvent extends MyGroupEvent {
  final String groupChatId;

  const JoinMyGroupEvent(this.groupChatId);
}

class UpdateDataFirestoreEvent extends MyGroupEvent {
  final String collectionPath;
  final String docPath;
  final Map<String, dynamic> dataNeedUpdate;
  const UpdateDataFirestoreEvent(
    this.collectionPath,
    this.docPath,
    this.dataNeedUpdate,
  );
}
