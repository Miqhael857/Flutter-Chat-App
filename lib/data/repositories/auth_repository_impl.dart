import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/data/datasources/firebase_remote_datasource.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';

class AuthRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> forgotPassword(String email) async =>
      await remoteDataSource.forgotPassword(email);

  @override
  Stream<List<UserEntity>> getAllUser() => remoteDataSource.getAllUser();

  @override
  Future<String> getCurrentUId() async =>
      await remoteDataSource.getCurrentUId();

  @override
  Future<void> googleAuth() async => await remoteDataSource.googleAuth();

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async =>
      await remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      await remoteDataSource.signUp(user);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      await remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<void> getUpdateUser(UserEntity user) async =>
      await remoteDataSource.getUpdateUser(user);

  @override
  Future<void> deleteUser(String userId) async =>
      await remoteDataSource.deleteUser(userId);

  @override
  Future<void> joinChatMessage(String groupChatId) async =>
      remoteDataSource.joinChatMessage(groupChatId);

  @override
  Future<void> updateDataFirestore(String collectionPath, String docPath,
          Map<String, dynamic> dataNeedUpdate) =>
      remoteDataSource.updateDataFirestore(
          collectionPath, docPath, dataNeedUpdate);

  @override
  Future<void> sendTextMessage(String receiverId, String message) async =>
      remoteDataSource.sendTextMessage(receiverId, message);

  @override
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) =>
      remoteDataSource.getMessages(userId, otherUserId);
}
