import 'package:chat_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

@immutable
class ApplicationStart{
  const ApplicationStart._();//dışarıan bir veri gelmiceği için sınıfı kappattık
  static Future<void> init() async {
     WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
);
  }
}