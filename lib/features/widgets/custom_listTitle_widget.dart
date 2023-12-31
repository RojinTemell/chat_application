// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chat_application/services/favoriteSong/favorite_song_service.dart';

import '../mixins/bottom_sheet_mixin.dart';

class CustomListTitle extends StatefulWidget with BottomSheetMixin {
  const CustomListTitle({
    Key? key,
    required this.artist,
    required this.imgPath,
    required this.song,
    required this.songUrl,
    required this.widget,
    required this.onTap,
    
  }) : super(key: key);
  final String artist;
  final String imgPath;
  final String song;
  final String songUrl;
  final Widget widget;
  final VoidCallback onTap;

  @override
  State<CustomListTitle> createState() => _CustomListTitleState();
}

class _CustomListTitleState extends State<CustomListTitle> {
  bool isTap = false;
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
            setState(() {
              isTap = !isTap;
            });
            if (isTap) {
              _songService.sendSong(
                  widget.artist, widget.imgPath, widget.song, widget.songUrl);
            } else {
              _songService.deleteSong(widget.song);
            }
          },
          child: isTap
              ? const FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red,
                )
              : const FaIcon(FontAwesomeIcons.heart),
        ),
      ),
    );
  }
}
