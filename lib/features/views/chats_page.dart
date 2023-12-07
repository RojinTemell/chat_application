import 'package:chat_application/features/mixins/navigator_manager.dart';
import 'package:chat_application/features/views/chat_page.dart';
import 'package:chat_application/features/views/maps_page.dart';
import 'package:chat_application/features/views/music_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ChatsScreen extends StatefulWidget with NavigatorManager {
  ChatsScreen({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1; // Başlangıç ekranını MusicScreen olarak ayarla

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
      body: _getSelectedPage(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedIndex: _selectedIndex, // Bu satırı ekleyerek seçili index'i belirtin
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.map, text: 'Maps'),
                GButton(icon: Icons.music_note, text: 'Music'),
                GButton(icon: Icons.message, text: 'Message'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return MapsScreen();
      case 1:
        return MusicScreen();
      case 2:
        return StreamBuilder<QuerySnapshot>(
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
                    .map<Widget>((doc) => _userListItem(doc, context))
                    .toList(),
              ),
            );
          },
        );
      default:
        return Container();
    }
  }

  Widget _userListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (widget._auth.currentUser!.email != data['email']) {
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
                ),
              );
            },
            child: const Icon(Icons.chevron_right),
          ),
          leading: const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn.bynogame.com/logo/bynocan-1-1678384668185.png'),
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
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
