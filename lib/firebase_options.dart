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
    apiKey: 'AIzaSyDu_iJ7x2iX-v3kKrOkdEocMCN4sJBme-o',
    appId: '1:647439214417:web:75ab0c87feff30aa861570',
    messagingSenderId: '647439214417',
    projectId: 'fir-login-6f8b8',
    authDomain: 'fir-login-6f8b8.firebaseapp.com',
    databaseURL: 'https://fir-login-6f8b8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-login-6f8b8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdwe1RxsT6BmJBDaUhYq1V0RYFNvvwXME',
    appId: '1:647439214417:android:3f0d3b50fc9ba03f861570',
    messagingSenderId: '647439214417',
    projectId: 'fir-login-6f8b8',
    databaseURL: 'https://fir-login-6f8b8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-login-6f8b8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCpMxZCuyX02SFNm4VlstE4t1AS5UJl2g',
    appId: '1:647439214417:ios:936b2addf05c005c861570',
    messagingSenderId: '647439214417',
    projectId: 'fir-login-6f8b8',
    databaseURL: 'https://fir-login-6f8b8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-login-6f8b8.appspot.com',
    iosClientId: '647439214417-kt0vi42r7i7nqjan317m84seaea247j9.apps.googleusercontent.com',
    iosBundleId: 'com.example.productManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCpMxZCuyX02SFNm4VlstE4t1AS5UJl2g',
    appId: '1:647439214417:ios:936b2addf05c005c861570',
    messagingSenderId: '647439214417',
    projectId: 'fir-login-6f8b8',
    databaseURL: 'https://fir-login-6f8b8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-login-6f8b8.appspot.com',
    iosClientId: '647439214417-kt0vi42r7i7nqjan317m84seaea247j9.apps.googleusercontent.com',
    iosBundleId: 'com.example.productManagement',
  );
}
