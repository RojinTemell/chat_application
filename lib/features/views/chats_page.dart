import 'package:chat_application/features/mixins/navigator_manager.dart';
import 'package:chat_application/features/views/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget with NavigatorManager {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final _auth = FirebaseAuth.instance;
  //sor ama başka bir snapshot ı da nasıl kullanabilirim
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('loading');
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => _userListItem(doc))
                    .toList(),
              ),
            );
          }),
    );
  }

  Widget _userListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: InkWell(
              onTap: () {
                widget.navigateToWidget(
                    context,
                    ChatScreen(
                      receiverName: data['email'],
                      receiverId: data['uid'],
                    ));
              },
              child: const Icon(Icons.chevron_right)),
          leading: const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.bynogame.com/logo/bynocan-1-1678384668185.png'), // burayı sonra kişi profilini doldurunca ekleriz
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 5,
                ),
              ),
            ],
          ),
          title: Text(data['name']),
          onTap: () {
            widget.navigateToWidget(
                context,
                ChatScreen(
                  receiverName: data['name'],
                  receiverId: data['uid'],
                ));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
