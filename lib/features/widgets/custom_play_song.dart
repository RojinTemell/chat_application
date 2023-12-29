import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySongContainer extends StatefulWidget {
  const PlaySongContainer({
    Key? key,
    required this.song,
    required this.artist,
    required this.imgPath,
    required this.songUrl,
  }) : super(key: key);

  final String song;
  final String artist;
  final String imgPath;
  final String songUrl;

  @override
  _PlaySongContainerState createState() => _PlaySongContainerState();
}

class _PlaySongContainerState extends State<PlaySongContainer> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.imgPath,
              height: size.height * 0.4,
              width: size.width * 0.85,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.artist,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
          Slider(
            min: 0,
            value: 0,
            onChanged: (value) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shuffle_rounded,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 45,
                ),
              ),
              IconButton(
                onPressed: () {
                  _playSong(widget.songUrl);
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  size: 90,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_next_rounded,
                  size: 45,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.repeat,
                  size: 40,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }

  void _playSong(String url) async {
  if (url.isNotEmpty) {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }
}

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
