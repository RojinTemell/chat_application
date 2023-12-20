// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SongCubit extends Cubit<SongState> {
//   SongCubit() : super(SongState());
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
//   Stream<QuerySnapshot> getSongs(String SanatciAdi, String SarkiAdi) {
//     List<String> ids = [SanatciAdi, SarkiAdi];
//     ids.sort();
//     String chatRoomId = ids.join('_');

//     return _firebaseFirestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }

// class SongState extends SongCubit {}
