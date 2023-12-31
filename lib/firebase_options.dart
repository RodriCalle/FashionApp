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
    apiKey: 'AIzaSyC4Zd-o32S6i5BlLUjnrKjWqxeIuczFmnc',
    appId: '1:441547778366:web:e08e2e1e0935cde0a1e46f',
    messagingSenderId: '441547778366',
    projectId: 'fashion-app-final',
    authDomain: 'fashion-app-final.firebaseapp.com',
    storageBucket: 'fashion-app-final.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFJYZI8agQZtyslTXGxHJLcTK8iyLoFwM',
    appId: '1:441547778366:android:ecb1256b05640cb9a1e46f',
    messagingSenderId: '441547778366',
    projectId: 'fashion-app-final',
    storageBucket: 'fashion-app-final.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1Ew7ES4OhKv0Dkt9edJhLECAFzfJATCY',
    appId: '1:441547778366:ios:c24a6b4aa224747fa1e46f',
    messagingSenderId: '441547778366',
    projectId: 'fashion-app-final',
    storageBucket: 'fashion-app-final.appspot.com',
    iosBundleId: 'com.example.demoFashionApp',
  );
}
