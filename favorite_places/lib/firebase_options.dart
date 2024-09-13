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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH1o1_3NLORrY2OUmBo6al12eRGI8T8T4',
    appId: '1:190557574554:android:94c536933a293b44785623',
    messagingSenderId: '190557574554',
    projectId: 'flutter-prep-d8e18',
    databaseURL: 'https://flutter-prep-d8e18-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-d8e18.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByyoACSh6KpK7EKfQzsnrylHr1B4d25do',
    appId: '1:190557574554:ios:98209f7a167e9fed785623',
    messagingSenderId: '190557574554',
    projectId: 'flutter-prep-d8e18',
    databaseURL: 'https://flutter-prep-d8e18-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-d8e18.appspot.com',
    iosBundleId: 'com.example.favoritePlaces',
  );
}
