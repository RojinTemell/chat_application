import 'package:chat_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chats_page.dart';
import 'maps_page.dart';
import 'music_page.dart';
import 'music_recognition_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const MusicScreen(),
    ChatsScreen(),
    const MusicRecognitionPage(),
    const MapsScreen(),
  ];

  Future<void> signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.music_note_outlined),
                label: 'Music',
                selectedIcon: Icon(Icons.music_note)),
            NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Chat',
                selectedIcon: Icon(Icons.chat_bubble)),
            NavigationDestination(
                icon: Icon(Icons.mic),
                label: 'Mic',
                selectedIcon: Icon(Icons.mic_external_off_outlined)),
            NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: 'Map',
                selectedIcon: Icon(Icons.map)),
          ]),
    );
  }
}
