import 'package:chat_application/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteSong {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Send song
  Future<void> sendSong(
      String artist, String imgPath, String song, String songUrl) async {
    // get current user info
    final currentUserId = _firebaseAuth.currentUser!.uid;
    final songQuery = await _firebaseFirestore
        .collection('favorSongs')
        .doc(currentUserId)
        .collection('favorites')
        .where('SarkiAdi', isEqualTo: song)
        .limit(1)
        .get();

    if (songQuery.docs.isEmpty) {
      SongModel newFavoriteSongs = SongModel(
        SanatciAdi: artist,
        SanatciFotoUrl: imgPath,
        SarkiAdi: song,
        SarkiUrl: songUrl,
        UserId: currentUserId,
      );

      await _firebaseFirestore
          .collection('favorSongs')
          .doc(currentUserId)
          .collection('favorites')
          .add(newFavoriteSongs.toJson());
    }
  }

  Stream<QuerySnapshot> getSongs() {
    final currentUserId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection('favorSongs')
        .doc(currentUserId)
        .collection('favorites')
        .snapshots();
  }

  Future<void> deleteSong(String song) async {
    final currentUserId = _firebaseAuth.currentUser!.uid;
    final delete_song = await _firebaseFirestore
        .collection('favorSongs')
        .doc(currentUserId)
        .collection('favorites')
        .where('SarkiAdi', isEqualTo: song)
        .limit(1)
        .get();

    if (delete_song.docs.isNotEmpty) {
      final songDocId = delete_song.docs.first.id;
      await _firebaseFirestore
          .collection('favorSongs')
          .doc(currentUserId)
          .collection('favorites')
          .doc(songDocId)
          .delete();
    }
  }
}
