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
    apiKey: 'AIzaSyBDwy7uqgDANb-JUNiz-8j91xklZGAwK_4',
    appId: '1:221979821247:web:27ecdf7248c667b6e4320a',
    messagingSenderId: '221979821247',
    projectId: 'pushservice-e6e2b',
    authDomain: 'pushservice-e6e2b.firebaseapp.com',
    storageBucket: 'pushservice-e6e2b.appspot.com',
    measurementId: 'G-T6P88XMZF8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPHuZrat-nYeArgj1u-gQLx2FcJqBJxls',
    appId: '1:221979821247:android:ae4edf66acd83005e4320a',
    messagingSenderId: '221979821247',
    projectId: 'pushservice-e6e2b',
    storageBucket: 'pushservice-e6e2b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuK_Ad_dHU-7vTRiyzs7Sta3UZWjaVLCU',
    appId: '1:221979821247:ios:b98059ebb7f2e945e4320a',
    messagingSenderId: '221979821247',
    projectId: 'pushservice-e6e2b',
    storageBucket: 'pushservice-e6e2b.appspot.com',
    iosBundleId: 'com.example.notificaciones',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuK_Ad_dHU-7vTRiyzs7Sta3UZWjaVLCU',
    appId: '1:221979821247:ios:cbc0c5f510f3c5dae4320a',
    messagingSenderId: '221979821247',
    projectId: 'pushservice-e6e2b',
    storageBucket: 'pushservice-e6e2b.appspot.com',
    iosBundleId: 'com.example.notificaciones.RunnerTests',
  );
}
