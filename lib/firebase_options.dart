// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAJAu_Z4TpbI6FonEkKNyPcCEyVjVr3Mv0',
    appId: '1:1037172241342:web:523004e6630ee5f3107fef',
    messagingSenderId: '1037172241342',
    projectId: 'baby-shop-8f76a',
    authDomain: 'baby-shop-8f76a.firebaseapp.com',
    databaseURL: 'https://baby-shop-8f76a-default-rtdb.firebaseio.com',
    storageBucket: 'baby-shop-8f76a.firebasestorage.app',
    measurementId: 'G-V8HXB5VK83',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8mYff4ix5AgsKhLQ7jwW_N-jXV7ZG6QQ',
    appId: '1:1037172241342:android:7e8091aace09bf8b107fef',
    messagingSenderId: '1037172241342',
    projectId: 'baby-shop-8f76a',
    databaseURL: 'https://baby-shop-8f76a-default-rtdb.firebaseio.com',
    storageBucket: 'baby-shop-8f76a.firebasestorage.app',
  );
}