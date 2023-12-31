import 'package:chat_application/features/views/favorite_songs.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'chats_page.dart';
// import 'maps_page.dart';
import 'music_page.dart';
// import 'music_recognition_page.dart';

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
    const FavoriteSongView(),
    // const MapsScreen(),
  ];

  Future<void> signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //     width: 64,
      //     height: 64,
      //     decoration: BoxDecoration(
      //         color: const Color.fromARGB(255, 4, 82, 121),
      //         borderRadius: BorderRadius.circular(32)),
      //     child: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.mic,
      //         size: 35,
      //       ),
      //     )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                icon: FaIcon(
                  FontAwesomeIcons.message,
                ),
                label: 'Chat',
                selectedIcon: Icon(Icons.chat_bubble)),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.heart),
                label: 'Fav',
                selectedIcon: FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red,
                )),
            // NavigationDestination(
            //     icon: Icon(Icons.map_outlined),
            //     label: 'Map',
            //     selectedIcon: Icon(Icons.map)),
          ]),
    );
  }
}
