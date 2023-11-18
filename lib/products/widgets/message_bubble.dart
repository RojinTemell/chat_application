import 'package:flutter/material.dart';
import 'package:chat_application/products/models/message_model.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.isImage,
  }) : super(key: key);

  final bool isMe;
  final bool isImage;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.grey : Colors.blue,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  isImage
                      ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(message.content),
                                    fit: BoxFit.cover)),
                          ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Text(
                            message.content,
                            style: const TextStyle(color: Colors.white),
                          ),
                      ),
                  
                  Text(
                    DateFormat('HH:mm').format(DateTime.now()),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
