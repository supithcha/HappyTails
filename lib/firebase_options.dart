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
    apiKey: 'AIzaSyBFJQlD2USX2ERBAwLPPBioJ_nzUgw0Da0',
    appId: '1:577250430112:web:a8db0842f5da09f1288dc5',
    messagingSenderId: '577250430112',
    projectId: 'happy-tails-5b4c1',
    authDomain: 'happy-tails-5b4c1.firebaseapp.com',
    storageBucket: 'happy-tails-5b4c1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAj3tfKQznINAkAK12d64IoToQR7QZYJOU',
    appId: '1:577250430112:android:75b4ddbe340d7b02288dc5',
    messagingSenderId: '577250430112',
    projectId: 'happy-tails-5b4c1',
    storageBucket: 'happy-tails-5b4c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-04okTJa8RBk9NcOrjxkVX5dQrzLH8pw',
    appId: '1:577250430112:ios:15b1e26b5ca39671288dc5',
    messagingSenderId: '577250430112',
    projectId: 'happy-tails-5b4c1',
    storageBucket: 'happy-tails-5b4c1.appspot.com',
    androidClientId: '577250430112-l9je3md0lbqht80chh3q742813f995tp.apps.googleusercontent.com',
    iosClientId: '577250430112-7s2a9vu96jj97q03gpueaarrfmhjbr0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.happytails',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-04okTJa8RBk9NcOrjxkVX5dQrzLH8pw',
    appId: '1:577250430112:ios:d147d86a2c311949288dc5',
    messagingSenderId: '577250430112',
    projectId: 'happy-tails-5b4c1',
    storageBucket: 'happy-tails-5b4c1.appspot.com',
    androidClientId: '577250430112-l9je3md0lbqht80chh3q742813f995tp.apps.googleusercontent.com',
    iosClientId: '577250430112-u6noq1rmvagp2lafo7kvrck4ou3n9lnh.apps.googleusercontent.com',
    iosBundleId: 'com.example.happytails.RunnerTests',
  );
}
