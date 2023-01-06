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
    apiKey: 'AIzaSyCjZedYatjnnAjMBIaPgSXh16D0vdR4kxg',
    appId: '1:560721510284:web:79a628646292d2fb4760a9',
    messagingSenderId: '560721510284',
    projectId: 'lettutor-beb38',
    authDomain: 'lettutor-beb38.firebaseapp.com',
    storageBucket: 'lettutor-beb38.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGDtFu-hc_FY1z6u50tnVD2TzxW5C6q4w',
    appId: '1:560721510284:android:10d9ad5796eb078c4760a9',
    messagingSenderId: '560721510284',
    projectId: 'lettutor-beb38',
    storageBucket: 'lettutor-beb38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuYoHKrdF5AKXIiVGXOgz_6GFVY187mlo',
    appId: '1:560721510284:ios:6977663f336ae40d4760a9',
    messagingSenderId: '560721510284',
    projectId: 'lettutor-beb38',
    storageBucket: 'lettutor-beb38.appspot.com',
    androidClientId: '560721510284-rnffufjk5bk3e8cimljbog47qpueled2.apps.googleusercontent.com',
    iosClientId: '560721510284-6i425m76dba1nudcge0mfddsmdt2fggf.apps.googleusercontent.com',
    iosBundleId: 'com.example.lettutorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuYoHKrdF5AKXIiVGXOgz_6GFVY187mlo',
    appId: '1:560721510284:ios:6977663f336ae40d4760a9',
    messagingSenderId: '560721510284',
    projectId: 'lettutor-beb38',
    storageBucket: 'lettutor-beb38.appspot.com',
    androidClientId: '560721510284-rnffufjk5bk3e8cimljbog47qpueled2.apps.googleusercontent.com',
    iosClientId: '560721510284-6i425m76dba1nudcge0mfddsmdt2fggf.apps.googleusercontent.com',
    iosBundleId: 'com.example.lettutorApp',
  );
}
