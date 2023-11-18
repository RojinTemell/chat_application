import 'package:chat_application/products/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;
  static Future<void> addTextMessage(
      {required String content, required String receiverId}) async {
    final message = MessageModel(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiverId,
        content: content,
        sentTime: DateTime.now(),
        messageType: MessageType.text);
    await _addMessageToChat(receiverId, message);
  }

   static Future<void> addImageMessage(
      {required Uint8List file, required String receiverId}) async {
   final image =await FirebaseStorageService.uploadImage(file,'image/chat/${DateTime.now()}');

   final message = MessageModel(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiverId,
        content: image,
        sentTime: DateTime.now(),
        messageType: MessageType.image);
        await _addMessageToChat(receiverId, message);
  }



  static Future<void> _addMessageToChat(
    String receiverId,
    MessageModel message,
  ) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId).collection('messages')
        .add(message.toJson());
    
    
  }
  
}
