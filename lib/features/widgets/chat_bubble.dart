import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
    
  }
}




class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    
    required this.isMe, required this.message,
    
  }) : super(key: key);

  final bool isMe;
  final String message;
 
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey,
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
                 Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Text(
                            message,
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