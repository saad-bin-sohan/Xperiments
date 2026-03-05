import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/core/config/app_flavor.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/firebase/firebase_options_dev.dart';
import 'package:mobile/core/firebase/remote_config_service.dart';

// TODO: iOS Firebase Config — when iOS build begins (~1 week):
// 1. Go to Firebase Console → Project Settings → Add App → iOS
// 2. Download GoogleService-Info.plist and add it to ios/Runner/ via Xcode
// 3. Run: flutterfire configure --platforms=android,ios
class FirebaseInitializer {
  const FirebaseInitializer._();

  static Future<void> initialize() async {
    final FirebaseOptions options;

    switch (Env.flavor) {
      case AppFlavor.dev:
        options = DefaultFirebaseOptionsDev.currentPlatform;
      case AppFlavor.prod:
        // Single Firebase project mode: prod flavor currently points to dev project.
        options = DefaultFirebaseOptionsDev.currentPlatform;
    }

    await Firebase.initializeApp(options: options);
    await remoteConfigService.initialize();
  }
}
