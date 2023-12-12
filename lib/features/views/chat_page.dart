import 'dart:async';

import 'package:chat_application/features/mixins/navigator_manager.dart';
import 'package:chat_application/features/widgets/chat_bubble.dart';
import 'package:chat_application/services/chat/chat_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/chat/chat_cubit.dart';
import '../widgets/textfield_widget.dart';
import 'chats_page.dart';

class ChatScreen extends StatelessWidget with NavigatorManager {
  ChatScreen({super.key, required this.receiverName, required this.receiverId});
  final String receiverName;
  final String receiverId;
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController scrollController = ScrollController();

  void scrollEvent() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    print('oldu');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigateToWidget(context, ChatsScreen());
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
              Text(receiverName),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _messageList()),
            _messageBuilt(),
          ],
        ),
      ),
    );
  }

  Widget _messageBuilt() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Row(
            children: [
              Expanded(
                  child: TextFieldWidget(
                callback: () {
                  Timer(Duration(milliseconds: 300), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                },
                hintText: 'Write some thing ...',
                keyboardType: TextInputType.text,
                controller: _messageController,
              )),
              IconButton(
                  onPressed: () {
                    context.read<ChatCubit>().sendMessage(receiverId,
                        _messageController.text, _messageController);
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
        );
      },
    );
  }

  Widget _messageList() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return StreamBuilder(
            stream: context
                .read<ChatCubit>()
                .getMessages(receiverId, _auth.currentUser!.uid),
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
              return ListView(
                children: data,
                controller: scrollController,
              );
            });
      },
    );
  }

  Widget _messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final bool value = data['senderId'] == _auth.currentUser!.uid;

    return MessageBubble(
      message: data['message'],
      isMe: value,
    );
  }
}