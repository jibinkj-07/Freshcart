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
    apiKey: 'AIzaSyAAueyyoTflyPj0IsUrNiL7yEEcmT51cPY',
    appId: '1:714966431579:android:a15283fe17258f4f58cc7e',
    messagingSenderId: '714966431579',
    projectId: 'freshcart-8696d',
    databaseURL: 'https://freshcart-8696d-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'freshcart-8696d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiUh6HvGS5fEzZNVV3ECDegusd85uArqM',
    appId: '1:714966431579:ios:9ae7cecbb4aa96bd58cc7e',
    messagingSenderId: '714966431579',
    projectId: 'freshcart-8696d',
    databaseURL: 'https://freshcart-8696d-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'freshcart-8696d.appspot.com',
    iosBundleId: 'com.codedude.freshCart',
  );

}