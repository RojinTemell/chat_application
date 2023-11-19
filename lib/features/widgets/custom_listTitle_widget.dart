import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.artist,
    required this.imgPath,
    required this.song, required this.callback,
  });
  final String artist;
  final String imgPath;
  final String song;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imgPath),
      title: Text(song),
      subtitle: Text('Song .$artist'),
      trailing: InkWell(
        onTap: callback,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
