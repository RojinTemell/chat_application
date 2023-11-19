// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDYVrZej7WDt4eaTysH0GXLdPiLXF2AuyI',
    appId: '1:359311780848:web:6fe702e2b51f4e2c210b35',
    messagingSenderId: '359311780848',
    projectId: 'chatapplication-d1fdc',
    authDomain: 'chatapplication-d1fdc.firebaseapp.com',
    storageBucket: 'chatapplication-d1fdc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcbMLgP39c9Z5tcJegWypN8ljooqVTXgc',
    appId: '1:359311780848:android:37efa5020d00d657210b35',
    messagingSenderId: '359311780848',
    projectId: 'chatapplication-d1fdc',
    storageBucket: 'chatapplication-d1fdc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuFr9pjN6dYMC1HCd-sckcKBgEyDpm2LU',
    appId: '1:359311780848:ios:4eb10953921e212f210b35',
    messagingSenderId: '359311780848',
    projectId: 'chatapplication-d1fdc',
    storageBucket: 'chatapplication-d1fdc.appspot.com',
    iosBundleId: 'com.example.chatApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuFr9pjN6dYMC1HCd-sckcKBgEyDpm2LU',
    appId: '1:359311780848:ios:1529cad88df8e1b6210b35',
    messagingSenderId: '359311780848',
    projectId: 'chatapplication-d1fdc',
    storageBucket: 'chatapplication-d1fdc.appspot.com',
    iosBundleId: 'com.example.chatApplication.RunnerTests',
  );
}