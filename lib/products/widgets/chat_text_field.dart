import 'dart:typed_data';

import 'package:chat_application/products/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../service/firebase_firestore-service.dart';
import '../../service/media_service.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.receiverId});
  final String receiverId;
  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
Uint8List? file;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _sendText(BuildContext context) async {
      if (controller.text.isNotEmpty) {
        await FirebaseFirestoreService.addTextMessage(
            content: controller.text, receiverId: widget.receiverId);
        controller.clear();
        FocusScope.of(context).unfocus();
      }
      FocusScope.of(context).unfocus();
    }
    void _sendImage()async{
      final pickedImage=await MediaService.pickImage();
      setState(() {
        file=pickedImage;
      });
      if(file !=null){
        await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!
        );
      }
    }

    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'Add Message ...',
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              _sendText(context);
            },
          ),
        ),
      ],
    );
  }
}
