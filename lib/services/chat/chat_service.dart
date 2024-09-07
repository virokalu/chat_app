import 'package:app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        //go through each individual user
        return user;
      }).toList();
    });
  }

  ///Get all Users accept Blocked Users Stream
  Stream<List<Map<String, dynamic>>> getUsersExcludingBlocksStream() {
    final currentUser = _auth.currentUser;
    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      // get list of blocked user ids
      final blockUserIds = snapshot.docs.map((doc) => doc.id).toList();

      // get all users
      final userSnapShot = await _firestore.collection('Users').get();

      //return as stream List
      return userSnapShot.docs
          .where((doc) =>
              doc.data()['email'] != currentUser.email &&
              !blockUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  ///send messages
  Future<void> sendMessage(String receiverId, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    // construct chat room ID for the 2 user
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add new message to database
    await _firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  ///get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct chat room ID for the 2 user
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  ///Report User
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('Reports').add(report);
  }

  ///Block User
  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  ///Unblock User
  Future<void> unblockUser(String blockUserId) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .doc(blockUserId)
        .delete();
    // notifyListeners();
  }

  ///Get Blocked User Stream
  Stream<List<Map<String, dynamic>>> getBlockedUsers(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('blockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      // get list of blocked user ids
      final blockUserIds = snapshot.docs.map((doc) => doc.id).toList();
      final userDocs = await Future.wait(
        blockUserIds.map((id) => _firestore.collection('Users').doc(id).get()),
      );
      // return as a List
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
