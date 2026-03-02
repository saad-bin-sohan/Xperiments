import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptionsDev {
  const DefaultFirebaseOptionsDev._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptionsDev has not been configured for web.',
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
          'DefaultFirebaseOptionsDev has not been configured for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'DEV_ANDROID_API_KEY',
    appId: '1:000000000000:android:dev000000000000',
    messagingSenderId: '000000000000',
    projectId: 'xperiments-dev',
    storageBucket: 'xperiments-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'DEV_IOS_API_KEY',
    appId: '1:000000000000:ios:dev000000000000',
    messagingSenderId: '000000000000',
    projectId: 'xperiments-dev',
    storageBucket: 'xperiments-dev.appspot.com',
    iosBundleId: 'com.xperiments.app',
  );
}
