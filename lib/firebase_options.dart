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
    apiKey: 'AIzaSyCykH66W5Ob1PQM9Pek_LctdOMyO4tRnY4',
    appId: '1:975370685021:web:70be02022a8601ada59bb4',
    messagingSenderId: '975370685021',
    projectId: 'attendance-1801d',
    authDomain: 'attendance-1801d.firebaseapp.com',
    storageBucket: 'attendance-1801d.appspot.com',
    measurementId: 'G-B5Q3PSHYML',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5NxT66n8jUo7Md0m-tLniO0tx-HA-Gos',
    appId: '1:975370685021:android:e2aea115b9923e1ca59bb4',
    messagingSenderId: '975370685021',
    projectId: 'attendance-1801d',
    storageBucket: 'attendance-1801d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnQMHI6ZJb9d7L-Cn3b-GUBBmHd6TlBiE',
    appId: '1:975370685021:ios:c13c0008abafdf08a59bb4',
    messagingSenderId: '975370685021',
    projectId: 'attendance-1801d',
    storageBucket: 'attendance-1801d.appspot.com',
    iosBundleId: 'com.example.attendanceManagementSystem',
  );
}
