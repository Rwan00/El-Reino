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
    apiKey: 'AIzaSyAdUNzJcv_p374aq14Ocu3b9nMc87QKSKw',
    appId: '1:747934362178:web:f622b473951ce305325bdb',
    messagingSenderId: '747934362178',
    projectId: 'el-reino-b4e94',
    authDomain: 'el-reino-b4e94.firebaseapp.com',
    storageBucket: 'el-reino-b4e94.appspot.com',
    measurementId: 'G-9SPB6GNN17',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCAignenT6r0LD89WfFSQ3r7uVxzVgvPQ',
    appId: '1:747934362178:android:e7dbc773e15ccf70325bdb',
    messagingSenderId: '747934362178',
    projectId: 'el-reino-b4e94',
    storageBucket: 'el-reino-b4e94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVhszs6PDaC4YihU2Vf66wJLbvfcDFTPU',
    appId: '1:747934362178:ios:7bc7d554cfdca59d325bdb',
    messagingSenderId: '747934362178',
    projectId: 'el-reino-b4e94',
    storageBucket: 'el-reino-b4e94.appspot.com',
    iosBundleId: 'com.example.elReino',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVhszs6PDaC4YihU2Vf66wJLbvfcDFTPU',
    appId: '1:747934362178:ios:2b43f46de9375b57325bdb',
    messagingSenderId: '747934362178',
    projectId: 'el-reino-b4e94',
    storageBucket: 'el-reino-b4e94.appspot.com',
    iosBundleId: 'com.example.elReino.RunnerTests',
  );
}