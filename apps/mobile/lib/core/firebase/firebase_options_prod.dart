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
    // Single Firebase project mode: keep prod flavor aligned with dev project.
    apiKey: 'AIzaSyDlL89dMrCYEL9y8YGrjxfV_XIXi4LxDEg',
    appId: '1:506602598766:android:bc5d19f63df91bd359517f',
    messagingSenderId: '506602598766',
    projectId: 'xperiments-dev',
    storageBucket: 'xperiments-dev.firebasestorage.app',
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
