import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserModel> users = [];// value
  

  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection('users')
        // .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }
}


//bu yollada kullanıcıları alabilirdik

// Future<List<UserModel>> getUsersFromFirestore() async {
//   List<UserModel> users = [];

//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    
//     users = querySnapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
//   } catch (e) {
//     // Hata durumunda yapılacaklar
//     print("Hata: $e");
//   }

//   return users;
// }
