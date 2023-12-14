import 'package:flutter/material.dart';

import '../mixins/bottom_sheet_mixin.dart';

class CustomListTitle extends StatelessWidget with BottomSheetMixin{
  const CustomListTitle({
    super.key,
    required this.artist,
    required this.imgPath,
    required this.song, required this.widget, required this.onTap,
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
        leading: Image.asset(imgPath),
        title: Text(song),
        subtitle: Text('Song .$artist'),
        trailing: InkWell(
          onTap: (){
            showBottomSheetCustom(context, widget);
          },
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
