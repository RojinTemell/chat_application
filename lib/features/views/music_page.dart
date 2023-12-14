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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
      ),
      body: ListView(children: [
        CustomListTitle(
          artist: 'Ajda Pekkan',
          widget:const CustomBottomSheetContainer(),
          imgPath: 'assets/stromae.jpeg',
          song: 'Haydi',
          onTap: () {
            showBottomSheetCustom(
                context,
               const PlaySongContainer(
                  artist: 'Stromae',
                  song: 'Haydi',
                  imgPath: 'assets/stromae.jpeg',
                ));
          },
        ),
        
      ]),
    );
  }
}
