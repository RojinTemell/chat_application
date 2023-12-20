import 'package:flutter/material.dart';

class PlaySongContainer extends StatelessWidget {
  const PlaySongContainer(
      {super.key,
      required this.song,
      required this.artist,
      required this.imgPath});
  final String song;
  final String artist;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgPath,
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
                      Text(song,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        artist,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.14,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        size: 30,
                      ))
                ],
              ),
            ),
            Slider(
                min: 0,
                value: 0,
                onChanged:
                    (value) {}), //burayı sonra müzik ile eşleştir max dışarıdan gelen şarkı süresi olucak
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle_rounded,
                      size: 40,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 45,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded,
                        size: 90)), // buraya baısnca icon değişicek onu unutma
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded, size: 45)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.repeat,
                      size: 40,
                    )),
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ));
  }
}
