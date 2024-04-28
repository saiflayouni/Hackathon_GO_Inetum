import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gogo/model/message.dart';

class ChatService extends ChangeNotifier {
  // Jib instance mil auth wil firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //SEND MESSAGES
  Future<void> sendMessage(String recieverId, String message) async {
    //Get current User Info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //CREATE A new message
    Message newMessage = Message(
        SenderId: currentUserId,
        SenderEmail: currentUserEmail,
        receiverId: recieverId,
        timestamp: timestamp,
        message: message);
    //construct chat room id from current user id and reciever id (sorted)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); //sort ids
    String chatroomId = ids.join("_" //combine the ids into a single string
        );
    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.tomap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //Construire room de chat a partir des id des users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
