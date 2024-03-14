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
    apiKey: 'AIzaSyDC5tuMaq6F6u7C9fgrQWYREEShfA6nS9g',
    appId: '1:131385874920:web:2d60225642b6d0204a2c5d',
    messagingSenderId: '131385874920',
    projectId: 'readnote-3fd76',
    authDomain: 'readnote-3fd76.firebaseapp.com',
    databaseURL: 'https://readnote-3fd76-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'readnote-3fd76.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVwXcpGejgg3GJwu8t2Rk9o3_w9IxJwd8',
    appId: '1:131385874920:android:d997f0014e62a5a54a2c5d',
    messagingSenderId: '131385874920',
    projectId: 'readnote-3fd76',
    databaseURL: 'https://readnote-3fd76-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'readnote-3fd76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCl5NADXl2Ca8CIixuB7r91CV7b2zk9wOQ',
    appId: '1:131385874920:ios:187262c657b487db4a2c5d',
    messagingSenderId: '131385874920',
    projectId: 'readnote-3fd76',
    databaseURL: 'https://readnote-3fd76-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'readnote-3fd76.appspot.com',
    iosBundleId: 'com.example.readnote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCl5NADXl2Ca8CIixuB7r91CV7b2zk9wOQ',
    appId: '1:131385874920:ios:ba2ec1de7a74cca54a2c5d',
    messagingSenderId: '131385874920',
    projectId: 'readnote-3fd76',
    databaseURL: 'https://readnote-3fd76-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'readnote-3fd76.appspot.com',
    iosBundleId: 'com.example.readnote.RunnerTests',
  );
}
