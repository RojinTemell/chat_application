import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

import '../methods/formatTime.dart';

class PlaySongContainer extends StatefulWidget {
  const PlaySongContainer(
      {Key? key,
      required this.song,
      required this.artist,
      required this.imgPath,
      required this.songUrl,
      required this.maps,
      required this.data,
      required this.currentIndex})
      : super(key: key);

  final String song;
  final String artist;
  final String imgPath;
  final String songUrl;
  final int currentIndex;

  final List<QueryDocumentSnapshot<Object?>> maps;
  final Map<String, dynamic> data;

  @override
  _PlaySongContainerState createState() => _PlaySongContainerState();
}

class _PlaySongContainerState extends State<PlaySongContainer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isLoop = false;
  bool isSpeed = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late Duration _lastPosition;
  void play() => _audioPlayer.play();
  String currentSong = ''; // Şu anki şarkının verisi
  String currentArtist = ''; // Şu anki sanatçının verisi
  String currentImgPath = ''; // Şu anki resmin verisi
  String currentSongUrl = '';
  int currentCount = 0;

  @override
  void initState() {
    super.initState();
    currentSong = widget.song;
    currentArtist = widget.artist;
    currentImgPath = widget.imgPath;
    currentSongUrl = widget.songUrl;
    currentCount = widget.currentIndex;
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
      if (event.processingState == ProcessingState.completed) {
        changeSong(false);
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

  void changeSong(bool isCheck) {
    int itemCount = widget.maps.length;
    setState(() {
      if (isCheck) {
        Map<String, dynamic>? previousData;
        if (currentCount > 0) {
          previousData =
              widget.maps[currentCount - 1].data() as Map<String, dynamic>?;
        }
        if (previousData != null) {
          changeMap(previousData);
          currentCount--;
        } else {
          print('previous boşş');
        }
      } else {
        Map<String, dynamic>? nextData;
        if (currentCount < itemCount - 1) {
          nextData =
              widget.maps[currentCount + 1].data() as Map<String, dynamic>?;
        }
        if (nextData != null) {
          changeMap(nextData);
          currentCount++;
        } else {
          print('next boşş');
        }
      }
    });
  }

  void changeMap(Map<String, dynamic>? map) {
    currentSong = map?['SarkiAdi'];
    currentArtist = map?['SanatciAdi'];
    currentSongUrl = map?['SarkiUrl'];
    currentImgPath = map?['SanatciFotoUrl'];

    position = Duration.zero;
    _lastPosition = Duration.zero;
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
              currentImgPath,
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
                      currentSong,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      currentArtist,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
          Slider(
            min: 0,
            max: max(0, duration.inSeconds.toDouble()),
            value: min(
                position.inSeconds.toDouble(), duration.inSeconds.toDouble()),
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
                  onPressed: () {
                    setState(() {
                      isSpeed = !isSpeed;
                    });
                    if (isSpeed) {
                      _audioPlayer.setSpeed(1.5);
                    } else {
                      _audioPlayer.setSpeed(1.0);
                    }
                  },
                  icon: isSpeed
                      ?const FaIcon(
                          FontAwesomeIcons.gauge,
                          color: Colors.black,
                        )
                      :const FaIcon(FontAwesomeIcons.gauge)),
              IconButton(
                onPressed: () {
                  _audioPlayer.stop();
                  changeSong(true);
                },
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
                    _playSong(currentSongUrl);
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
                onPressed: () {
                  _audioPlayer.stop();
                  changeSong(false);
                },
                icon: const Icon(
                  Icons.skip_next_rounded,
                  size: 45,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isLoop = !isLoop;
                    });
                    if (isLoop) {
                      _audioPlayer.setLoopMode(LoopMode.all);
                    } else {
                      _audioPlayer.setLoopMode(LoopMode.off);
                    }
                  },
                  icon: isLoop
                      ? const FaIcon(
                          FontAwesomeIcons.repeat,
                          color: Colors.black,
                          size: 30,
                        )
                      : const FaIcon(FontAwesomeIcons.repeat)),
            ],
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
