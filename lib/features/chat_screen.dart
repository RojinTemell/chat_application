// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/features/chat_messeges.dart';
import 'package:flutter/material.dart';
import '../products/models/user_model.dart';
import '../products/widgets/chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          ChatMessages(
            receiverId: widget.user.uid,
          ),
           ChatTextField(receiverId: widget.user.uid,),
        ]),
      ),
    );
  }

  AppBar _customAppBar() => AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.image),
              radius: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(widget.user.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                  widget.user.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                      color: widget.user.isOnline ? Colors.green : Colors.grey,
                      fontSize: 14),
                )
              ],
            )
          ],
        ),
      );
}
