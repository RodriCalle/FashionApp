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
    apiKey: 'AIzaSyBEXazGbetxUeWRVKB3m40qRhwijDQ9Lhg',
    appId: '1:405314841033:web:54baa51bab081c209a6018',
    messagingSenderId: '405314841033',
    projectId: 'fashionapp-17e0b',
    authDomain: 'fashionapp-17e0b.firebaseapp.com',
    storageBucket: 'fashionapp-17e0b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4wfzk1vkZhnjDJT9QPWpvmmelGVYO9yo',
    appId: '1:405314841033:android:9552f037649c7e579a6018',
    messagingSenderId: '405314841033',
    projectId: 'fashionapp-17e0b',
    storageBucket: 'fashionapp-17e0b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdk6rtm8FzJ89DmvpYXm1_tod8e6ZlCh8',
    appId: '1:405314841033:ios:539cf4ebab5062819a6018',
    messagingSenderId: '405314841033',
    projectId: 'fashionapp-17e0b',
    storageBucket: 'fashionapp-17e0b.appspot.com',
    iosClientId: '405314841033-6j0gfro0j7udba3jg7eh666faods3hcn.apps.googleusercontent.com',
    iosBundleId: 'com.example.demoFashionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDdk6rtm8FzJ89DmvpYXm1_tod8e6ZlCh8',
    appId: '1:405314841033:ios:539cf4ebab5062819a6018',
    messagingSenderId: '405314841033',
    projectId: 'fashionapp-17e0b',
    storageBucket: 'fashionapp-17e0b.appspot.com',
    iosClientId: '405314841033-6j0gfro0j7udba3jg7eh666faods3hcn.apps.googleusercontent.com',
    iosBundleId: 'com.example.demoFashionApp',
  );
}
