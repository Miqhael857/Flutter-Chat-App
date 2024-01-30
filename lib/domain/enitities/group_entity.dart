import 'package:cloud_firestore/cloud_firestore.dart';

class GroupEntity {
  final String groupName;
  final String groupProfileImage;
  final String joinUsers;
  final String limitUsers;
  final Timestamp? creationTime;
  final String groupId;
  final String uid;
  final String lastMessage;
  
  const GroupEntity({
    this.groupName = "",
    this.groupProfileImage = "",
    this.joinUsers = "",
    this.limitUsers = "",
    this.creationTime,
    this.groupId = "",
    this.uid = "",
    this.lastMessage = "",
  });


  List<Object?> get props => [
        groupName,
        groupProfileImage,
        joinUsers,
        limitUsers,
        creationTime,
        groupId,
        uid,
        lastMessage,
      ];
}
