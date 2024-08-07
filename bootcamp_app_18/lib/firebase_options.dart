// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyASP3EGzuoaXjPGP_5mLLD0T5mIXu3vYWw',
    appId: '1:1068073694700:web:f4b3b6d4d15cf49fc2fcc9',
    messagingSenderId: '1068073694700',
    projectId: 'proodos-fit',
    authDomain: 'proodos-fit.firebaseapp.com',
    storageBucket: 'proodos-fit.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5Ux96USrubv-9R5YREFcVMnxrrL-z0QY',
    appId: '1:1068073694700:android:549ddd73f28a2ba6c2fcc9',
    messagingSenderId: '1068073694700',
    projectId: 'proodos-fit',
    storageBucket: 'proodos-fit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDChtk0gZdi4PzJYzriQrMrIGe2R-WPbxo',
    appId: '1:1068073694700:ios:b13312cf1dd81fdbc2fcc9',
    messagingSenderId: '1068073694700',
    projectId: 'proodos-fit',
    storageBucket: 'proodos-fit.appspot.com',
    iosBundleId: 'com.example.bootcampApp18',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDChtk0gZdi4PzJYzriQrMrIGe2R-WPbxo',
    appId: '1:1068073694700:ios:b13312cf1dd81fdbc2fcc9',
    messagingSenderId: '1068073694700',
    projectId: 'proodos-fit',
    storageBucket: 'proodos-fit.appspot.com',
    iosBundleId: 'com.example.bootcampApp18',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASP3EGzuoaXjPGP_5mLLD0T5mIXu3vYWw',
    appId: '1:1068073694700:web:7a244bf46be0798dc2fcc9',
    messagingSenderId: '1068073694700',
    projectId: 'proodos-fit',
    authDomain: 'proodos-fit.firebaseapp.com',
    storageBucket: 'proodos-fit.appspot.com',
  );
}
