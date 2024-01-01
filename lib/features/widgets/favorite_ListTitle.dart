// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chat_application/services/favoriteSong/favorite_song_service.dart';

import '../mixins/bottom_sheet_mixin.dart';

class FavoriListTitle extends StatefulWidget with BottomSheetMixin {
  const FavoriListTitle({
    Key? key,
    required this.artist,
    required this.imgPath,
    required this.song,
    required this.songUrl,
    
    required this.onTap,
    
  }) : super(key: key);
  final String artist;
  final String imgPath;
  final String song;
  final String songUrl;
  final VoidCallback onTap;
  
  @override
  State<FavoriListTitle> createState() => _FavoriListTitleState();
}

class _FavoriListTitleState extends State<FavoriListTitle> {
  
  FavoriteSong _songService = FavoriteSong();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(widget.imgPath),
            width: MediaQuery.of(context).size.width * 0.17,
            height: MediaQuery.of(context).size.height * 0.07,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(widget.song),
        subtitle: Text('Song .${widget.artist}'),
        trailing: InkWell(
          onTap: () {
            _songService.deleteSong(widget.song);
          },
          child: const FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
