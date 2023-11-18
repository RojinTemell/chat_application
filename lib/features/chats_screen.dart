import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/providers/firebase_provider.dart';
import '../products/widgets/user_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context, value, child) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, builder) => const SizedBox(
                    height: 10,
                  ),
              physics: const BouncingScrollPhysics(),
              itemCount: value.users.length,
              itemBuilder: (context, index) => value.users[index].uid !=
                      FirebaseAuth.instance.currentUser?.uid
                  ? UserItem(
                      user: value.users[index],
                    )
                  : const SizedBox());
        },
      ),
    );
  }
}
