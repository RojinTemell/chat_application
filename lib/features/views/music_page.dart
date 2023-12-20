import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mixins/bottom_sheet_mixin.dart';
import '../widgets/custom_bottomsheet_container.dart';
import '../widgets/custom_listTitle_widget.dart';
import '../widgets/custom_play_song.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with BottomSheetMixin {
  final _store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.find_replace))
          ],
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.menu_open_outlined)),
          title: const Text('Music'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _store.collection('songs').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('loading');
            }
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: snapshot.data!.docs.map<Widget>((doc) {
                    Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;
                    return Card(
                      child: CustomListTitle(
                        artist: data['SanatciAdi'],
                        widget: const CustomBottomSheetContainer(),
                        imgPath: data['SanatciFotoUrl'],
                        song: data['SarkiAdi'],
                        onTap: () {
                          showBottomSheetCustom(
                              context,
                              PlaySongContainer(
                                artist: data['SanatciAdi'],
                                song: data['SarkiAdi'],
                                imgPath:'https://firebasestorage.googleapis.com/v0/b/chatapplication-d1fdc.appspot.com/o/sanatciFoto%2FAbdal.jpeg?alt=media&token=e9f94b07-f8bc-4ac8-b999-474f3f4cd685 ',
                              ));
                        },
                      ),
                    );
                  }).toList(),
                ));
          },
        ));
  }
}
