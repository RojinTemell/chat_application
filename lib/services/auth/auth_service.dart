import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //sign user in

  Future<UserCredential> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a new user
  Future<UserCredential> signUpUser(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email, 'name': name});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }
}
