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
    apiKey: 'AIzaSyBjHLc_SrUmzwCn4BMLLvKFHY3O6ECoaFI',
    appId: '1:1074506106271:web:1b933051ab47d0e4eca9aa',
    messagingSenderId: '1074506106271',
    projectId: 'yoke-f9158',
    authDomain: 'yoke-f9158.firebaseapp.com',
    storageBucket: 'yoke-f9158.appspot.com',
    measurementId: 'G-GVKN57DGQY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzrVYe8GdfjCJKxP8RZezxXpolbSvER74',
    appId: '1:1074506106271:android:1e162e549802867aeca9aa',
    messagingSenderId: '1074506106271',
    projectId: 'yoke-f9158',
    storageBucket: 'yoke-f9158.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4v7aJO6mnJ-WL-d1QFLNX8CmXRMRLhxM',
    appId: '1:1074506106271:ios:ade2ea51437bc60aeca9aa',
    messagingSenderId: '1074506106271',
    projectId: 'yoke-f9158',
    storageBucket: 'yoke-f9158.appspot.com',
    iosClientId: '1074506106271-baoj226s7ntnjjdabta215ebceu2062b.apps.googleusercontent.com',
    iosBundleId: 'com.example.yokeApp4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4v7aJO6mnJ-WL-d1QFLNX8CmXRMRLhxM',
    appId: '1:1074506106271:ios:b0100825c7a8aea5eca9aa',
    messagingSenderId: '1074506106271',
    projectId: 'yoke-f9158',
    storageBucket: 'yoke-f9158.appspot.com',
    iosClientId: '1074506106271-ehf1kmamap4ssl9bjv5gh6h89vev9r3u.apps.googleusercontent.com',
    iosBundleId: 'com.example.yokeApp4.RunnerTests',
  );
}
