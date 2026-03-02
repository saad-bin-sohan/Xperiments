import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptionsProd {
  const DefaultFirebaseOptionsProd._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptionsProd has not been configured for web.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptionsProd has not been configured for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PROD_ANDROID_API_KEY',
    appId: '1:000000000000:android:prod000000000000',
    messagingSenderId: '000000000000',
    projectId: 'xperiments-prod',
    storageBucket: 'xperiments-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PROD_IOS_API_KEY',
    appId: '1:000000000000:ios:prod000000000000',
    messagingSenderId: '000000000000',
    projectId: 'xperiments-prod',
    storageBucket: 'xperiments-prod.appspot.com',
    iosBundleId: 'com.xperiments.app',
  );
}
