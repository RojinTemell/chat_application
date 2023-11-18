import 'package:chat_application/products/models/message_model.dart';
import 'package:flutter/material.dart';

import '../products/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.receiverId});

  final String receiverId;
  final messages = [
    MessageModel(
        senderId: 'x10Kxkc0vt9co8nQQQn1',
        receiverId: 'YR8mvMIM9IWfQH1dXE8f',
        content: 'hello',
        sentTime: DateTime.now(),
        messageType: MessageType.text),
    MessageModel(
        senderId: 'YR8mvMIM9IWfQH1dXE8f',
        receiverId: 'x10Kxkc0vt9co8nQQQn1',
        content: 'hi',
        sentTime: DateTime.now(),
        messageType: MessageType.text),
    MessageModel(
        senderId: 'x10Kxkc0vt9co8nQQQn1',
        receiverId: 'YR8mvMIM9IWfQH1dXE8f',
        content: 'https://cdn.bynogame.com/logo/bynocan-head-1678387708643.jpeg',
        sentTime: DateTime.now(),
        messageType: MessageType.image),
    MessageModel(
        senderId: 'YR8mvMIM9IWfQH1dXE8f',
        receiverId: 'x10Kxkc0vt9co8nQQQn1',
        content: 'great',
        sentTime: DateTime.now(),
        messageType: MessageType.text),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final isTextMessage = messages[index].messageType == MessageType.text;
            final isMe = receiverId != messages[index].senderId;
            return isTextMessage
                ? MessageBubble(
                    message: messages[index],
                    isMe: isMe,
                    isImage: false,
                  )
                : MessageBubble(
                    message: messages[index],
                    isMe: isMe,
                    isImage: true,
                  );
          }),
    );
  }
}
