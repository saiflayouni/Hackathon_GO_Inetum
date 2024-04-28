import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  final String SenderId;
  final String SenderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.SenderId,
    required this.SenderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
  });
  //convert to map (firebase convert)
  Map<String, dynamic> tomap() {
    return {
      'senderId' : SenderId,
      'senderEmail' : SenderEmail ,
      'message' : message ,
      'receiverId' : receiverId,
      'timestamp' :timestamp,
    };
  }
}
