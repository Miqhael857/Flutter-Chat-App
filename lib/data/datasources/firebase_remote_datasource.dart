import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  // get all user
  Stream<List<UserEntity>> getAllUser();

  // signup
  Future<void> signUp(UserEntity user);

  // signin
  Future<void> signIn(UserEntity user);

  // signout
  Future<void> signOut();

  // userId
  Future<String> getCurrentUId();

  // user logged in
  Future<bool> isSignIn();

  // google sign in
  Future<void> googleAuth();

  // forgot password
  Future<void> forgotPassword(String email);

  // get current user
  Future<void> getCreateCurrentUser(UserEntity user);

  // get update user
  Future<void> getUpdateUser(UserEntity user);

  // delete user
  Future<void> deleteUser(String userId);

  // join chat
  Future<void> joinChatMessage(String groupChatId);

  // update firestore
  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate);

  // send text message
  Future<void> sendTextMessage(String receiverId, String message);

  // get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId); 
}
