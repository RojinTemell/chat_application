import 'package:flutter/material.dart';

import '../mixins/bottom_sheet_mixin.dart';

class CustomListTitle extends StatelessWidget with BottomSheetMixin {
  const CustomListTitle({
    super.key,
    required this.artist,
    required this.imgPath,
    required this.song,
    required this.widget,
    required this.onTap,
  });
  final String artist;
  final String imgPath;
  final String song;
  final Widget widget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(imgPath),
            width: MediaQuery.of(context).size.width * 0.17,
            height: MediaQuery.of(context).size.height * 0.07,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(song),
        subtitle: Text('Song .$artist'),
        trailing: InkWell(
          onTap: () {
            showBottomSheetCustom(context, widget);
          },
          child: const Icon(Icons.heart_broken),//burayı değiştirirsin
        ),
      ),
    );
  }
}
