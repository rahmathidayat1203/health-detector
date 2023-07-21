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
    apiKey: 'AIzaSyBKhdXAFCFTrGoS4L02fbJ5JsRaxqQa8N8',
    appId: '1:112407729890:android:3bb80f743d96b8e1a670bb',
    messagingSenderId: '112407729890',
    projectId: 'applicationofhealth',
    databaseURL: 'https://applicationofhealth-default-rtdb.firebaseio.com',
    storageBucket: 'applicationofhealth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8yQoN7EB6Tnqligln67Hfm94KJiyorQ0',
    appId: '1:112407729890:ios:1331d89da2517927a670bb',
    messagingSenderId: '112407729890',
    projectId: 'applicationofhealth',
    databaseURL: 'https://applicationofhealth-default-rtdb.firebaseio.com',
    storageBucket: 'applicationofhealth.appspot.com',
    androidClientId:
        '112407729890-mvnm0a85np5v732orihcvba8op4s3roe.apps.googleusercontent.com',
    iosClientId:
        '112407729890-cmal3vb6gq5kr1vlvdsb0hg303eq477t.apps.googleusercontent.com',
    iosBundleId: 'com.aplikasihealthdetector.aplikasiHealthDetectorRev1',
  );
}