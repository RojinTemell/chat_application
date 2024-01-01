import 'package:flutter/material.dart';
import 'package:chat_application/services/favoriteSong/favorite_song_service.dart';
import '../mixins/bottom_sheet_mixin.dart';
import '../widgets/custom_play_song.dart';
import '../widgets/favorite_ListTitle.dart';

class FavoriteSongView extends StatefulWidget {
  const FavoriteSongView({super.key});

  @override
  State<FavoriteSongView> createState() => _FavoriteSongViewState();
}

class _FavoriteSongViewState extends State<FavoriteSongView>
    with BottomSheetMixin {
  FavoriteSong songs = FavoriteSong();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Favorites'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: songs.getSongs(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('loading');
            }

            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                  int currentIndex = 0;
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i].id == e.id) {
                      currentIndex = i;
                    }
                  }

                  return Card(
                    child: FavoriListTitle(
                        artist: data['SanatciAdi'] ?? '',
                        imgPath: data['SanatciFotoUrl'],
                        song: data['SarkiAdi'] ?? '',
                        songUrl: data['SarkiUrl'] ?? '',
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            PlaySongContainer(
                              artist: data['SanatciAdi'] ?? '',
                              song: data['SarkiAdi'] ?? '',
                              imgPath: data['SanatciFotoUrl'],
                              songUrl: data['SarkiUrl'] ?? '',
                              data: data,
                              maps: snapshot.data!.docs,
                              currentIndex: currentIndex,
                            ),
                          );
                        }),
                  );
                }).toList(),
              ),
            );
          })),
    );
  }
}
