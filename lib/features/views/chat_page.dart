import 'package:chat_application/features/mixins/navigator_manager.dart';
import 'package:chat_application/features/widgets/chat_bubble.dart';
import 'package:chat_application/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/textfield_widget.dart';
import 'chats_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.receiverName, required this.receiverId});
  final String receiverName;
  final String receiverId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with NavigatorManager {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessages() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigateToWidget(context, const ChatsScreen());
            },
            icon: const Icon(Icons.chevron_left)),
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://cdn.bynogame.com/logo/bynocan-1-1678384668185.png'), // burayı sonra kişi profilini doldurunca ekleriz
              ),
            ),
            // SizedBox(width: 10,),
            Text(widget.receiverName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _messageList()),
          _messageBuilt(),
        ],
      ),
    );
  }

  Widget _messageBuilt() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Row(
        children: [
          Expanded(
              child: TextFieldWidget(
            hintText: 'Write some thing ...',
            keyboardType: TextInputType.text,
            controller: _messageController,
          )),
          IconButton(onPressed: sendMessages, icon: const Icon(Icons.send))
        ],
      ),
    );
  }

  Widget _messageList() {
    return StreamBuilder(
        stream:
            _chatService.getMessages(widget.receiverId, _auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading');
          }
          final data = snapshot.data!.docs
              .map((document) => _messageItem(document))
              .toList();
          return ListView(children: data);
        });
  }

  Widget _messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final bool value = data['senderId'] == _auth.currentUser!.uid;
    // var aligment = (value)
    //     ? Alignment.centerRight
    //     : Alignment.centerLeft;

    return MessageBubble(
      message: data['message'],
      isMe: value,
    );
  }
}
