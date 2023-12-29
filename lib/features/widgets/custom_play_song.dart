import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySongContainer extends StatefulWidget {
  const PlaySongContainer({
    Key? key,
    required this.song,
    required this.artist,
    required this.imgPath,
    required this.songUrl, required this.map,
  }) : super(key: key);

  final String song;
  final String artist;
  final String imgPath;
  final String songUrl;
  final Map<String, dynamic> map;

  @override
  _PlaySongContainerState createState() => _PlaySongContainerState();
}

class _PlaySongContainerState extends State<PlaySongContainer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late Duration _lastPosition;
  void play() => _audioPlayer.play();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _lastPosition = Duration.zero;
    _audioPlayer.playerStateStream.listen((event) {
      if (event.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
      _audioPlayer.positionStream.listen((event) {
        setState(() {
          position = event;
        });
      });
      _audioPlayer.durationStream.listen((event) {
        setState(() {
          duration = event ?? Duration.zero;
        });
      });
    });
  }

  void _updatePosition(Duration duration) {
    setState(() {
      _lastPosition = position;
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
  void _playSong(String url) async {
    if (url.isNotEmpty) {
      if (_lastPosition != Duration.zero) {
        await _audioPlayer.seek(_lastPosition);
      } else {
        await _audioPlayer.setUrl(url);
      }

      _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPreviousSong(){
    String? currentSong;
    widget.map.forEach((key, value) {
      if(value==widget.songUrl){
        currentSong=key;
      }
    });
    if (currentSong!=null) {
      int currentIndex=widget.map.keys.toList().indexOf(currentSong!);
      if(currentIndex>0){
        String previousSong=widget.map.keys.toList()[currentIndex-1];
        String previousSongUrl=widget.map[previousSong]!;
        _playSong(previousSongUrl);
      }
      
    }
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration - position)),
              ],
            ),
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
                onPressed: _playPreviousSong,
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 45,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isPlaying) {
                    _updatePosition(position);
                    _audioPlayer.pause();
                  } else {
                    _playSong(widget.songUrl);
                  }
                },
                icon: isPlaying
                    ? const Icon(
                        Icons.pause,
                        size: 80,
                      )
                    : const Icon(
                        Icons.play_arrow_rounded,
                        size: 80,
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

  
}
