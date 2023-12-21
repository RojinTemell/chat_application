import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mixins/bottom_sheet_mixin.dart';
import '../widgets/custom_bottomsheet_container.dart';
import '../widgets/custom_listTitle_widget.dart';
import '../widgets/custom_play_song.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with BottomSheetMixin {
  final _store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.find_replace))],
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu_open_outlined)),
        title: const Text('Music'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.collection('songs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: snapshot.data!.docs.map<Widget>((doc) {
                Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                String imgPath = data != null && data.containsKey('SanatciFotoUrl') && data['SanatciFotoUrl'] is String
                    ? data['SanatciFotoUrl']
                    : 'Varsayilan_Url';

                return Card(
                  child: CustomListTitle(
                    artist: data?['SanatciAdi'] ?? '',
                    widget: const CustomBottomSheetContainer(),
                    imgPath: imgPath,
                    song: data?['SarkiAdi'] ?? '',
                    onTap: () {
                      showBottomSheetCustom(
                        context,
                        PlaySongContainer(
                          artist: data?['SanatciAdi'] ?? '',
                          song: data?['SarkiAdi'] ?? '',
                          imgPath: imgPath,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
