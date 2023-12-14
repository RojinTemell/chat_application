import 'dart:convert';
// import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class MusicRecognitionService extends Cubit<MusicInfo> {
  MusicRecognitionService() : super(MusicInfo(artist: '', title: ''));
  static const String _apiKey = '0ced8e12b387eab57cfe791e471094de';
  Future<void> recognizeMusic() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.audd.io/?api_token=$_apiKey&method=findLyrics'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] == 'success') {
          String title = jsonResponse['title'];
          String artist = jsonResponse['artist'];

          print('müzik adı:$title');
          print('sanatçı  adı:$artist');
          emit(MusicInfo(artist: artist, title: title));
        } else {
          print('müzik tanınmadı');
        }
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}

class MusicInfo {
  final String title;
  final String artist;

  MusicInfo({required this.artist, required this.title});
}
