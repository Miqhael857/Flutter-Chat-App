import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/data/datasources/firebase_remote_datasource.dart';
import 'package:flutter_chat_app/data/model/auth_model.dart';
import 'package:flutter_chat_app/data/model/chat_messages_model.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirebaseRemoteDataSourceImpl(this.firestore, this.auth, this.googleSignIn);

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Stream<List<UserEntity>> getAllUser() {
    final userCollection = firestore.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AuthModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<void> googleAuth() async {
    final usersCollection = firestore.collection("users");

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final firebaseUser = (await auth.signInWithCredential(credential)).user;
      usersCollection.doc(auth.currentUser!.uid).get().then((user) {
        if (!user.exists) {
          var uid = auth.currentUser!.uid;
          var newUser = AuthModel(
                  name: firebaseUser!.displayName!,
                  email: firebaseUser.email!,
                  phoneNumber: firebaseUser.phoneNumber == null
                      ? ""
                      : firebaseUser.phoneNumber!,
                  photoUrl: firebaseUser.photoURL == null
                      ? ""
                      : firebaseUser.photoURL!,
                  isOnline: false,
                  status: "",
                  uid: firebaseUser.uid)
              .toDocument();
          usersCollection.doc(uid).set(newUser);
        }
      }).whenComplete(() {
        print("New User Created Successfully");
      }).catchError((e) {
        print("getInitializeCreateCurrentUser ${e.toString()}");
      });
    } catch (e) {}
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw ('Authentication failed. Wrong Credentials');
      }
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is to weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = firestore.collection("users");
    final uid = await getCurrentUId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = AuthModel(
        name: user.name,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        photoUrl: user.photoUrl,
        isOnline: user.isOnline,
        status: user.status,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        print("user already exist");
        return;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    Map<String, dynamic> userInformation = {};
    print(user.name);

    await FirebaseAuth.instance.currentUser!.updateEmail(user.email);

    final userCollection = firestore.collection("users");
    if (user.photoUrl != "") {
      userInformation['photoUrl'] = user.photoUrl;
    }
    if (user.status != "") {
      userInformation['status'] = user.status;
    }
    if (user.phoneNumber != "") {
      userInformation["phoneNumber"] = user.phoneNumber;
    }
    if (user.name != "") {
      userInformation["name"] = user.name;
    }
    if (user.email != "") {
      userInformation["email"] = user.email;
    }
    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> deleteUser(String userId) async {
    final userRef = firestore.collection("users").doc(userId);
    final userAuthRef = auth.currentUser;

    print('id: $userId');
    userRef.delete().then((doc) => print('User doc has been deleting'),
        onError: (e) => print("Error delete User $e"));
    userAuthRef?.delete().then((doc) => print('User auth has been deleting'),
        onError: (e) => print("Error delete auth User $e"));
  }

  @override
  Future<void> joinChatMessage(String groupChatId) async {
    final chatCollection = firestore.collection("groupChatChannel");

    chatCollection.doc(groupChatId).get().then((groupChannel) {
      Map<String, dynamic> groupMap = {"groupChatChannel": groupChatId};
      if (!groupChannel.exists) {
        chatCollection.doc(groupChatId).set(groupMap);
        return;
      }
      return;
    });
  }

  @override
  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  @override
  Future<void> sendTextMessage(String receiverId, String message) async {
    final String currentUserEmail = auth.currentUser!.email.toString();
    final String currentUserId = auth.currentUser!.uid;

    ChatMessagesModel chatMessagesModel = ChatMessagesModel(
      message: message,
      receiverId: receiverId,
      senderEmail: currentUserEmail,
      senderId: currentUserId,
      timestamp: Timestamp.now(),
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(chatMessagesModel.toMap());
    // await firestore.collection('chat').add(chatMessagesModel.toMap());
  }

  @override
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
