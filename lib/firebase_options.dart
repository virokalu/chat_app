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
    apiKey: 'AIzaSyCu1LaUC0OkmR0X-xu2hjddUx6xhBycXMM',
    appId: '1:142968053581:web:bb777609fa6455c919a104',
    messagingSenderId: '142968053581',
    projectId: 'chat-app-cb122',
    authDomain: 'chat-app-cb122.firebaseapp.com',
    storageBucket: 'chat-app-cb122.appspot.com',
    measurementId: 'G-FJEHD23B9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFfdL8S0KpqCmieUIUrKVmQgLrG8qg4KM',
    appId: '1:142968053581:android:ffb713d5222b7e6019a104',
    messagingSenderId: '142968053581',
    projectId: 'chat-app-cb122',
    storageBucket: 'chat-app-cb122.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvh4CrNd_YDq59v6mJ37RC1fyCJI0ULl4',
    appId: '1:142968053581:ios:f1cec35056f0170f19a104',
    messagingSenderId: '142968053581',
    projectId: 'chat-app-cb122',
    storageBucket: 'chat-app-cb122.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvh4CrNd_YDq59v6mJ37RC1fyCJI0ULl4',
    appId: '1:142968053581:ios:f1cec35056f0170f19a104',
    messagingSenderId: '142968053581',
    projectId: 'chat-app-cb122',
    storageBucket: 'chat-app-cb122.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCu1LaUC0OkmR0X-xu2hjddUx6xhBycXMM',
    appId: '1:142968053581:web:240a4b81e8d3c08019a104',
    messagingSenderId: '142968053581',
    projectId: 'chat-app-cb122',
    authDomain: 'chat-app-cb122.firebaseapp.com',
    storageBucket: 'chat-app-cb122.appspot.com',
    measurementId: 'G-2F4410M3B2',
  );

}