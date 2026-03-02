import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile/core/config/app_flavor.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/firebase/firebase_options_dev.dart';
import 'package:mobile/core/firebase/firebase_options_prod.dart';

FirebaseOptions _resolveOptions() {
  switch (Env.flavor) {
    case AppFlavor.dev:
      return DefaultFirebaseOptionsDev.currentPlatform;
    case AppFlavor.prod:
      return DefaultFirebaseOptionsProd.currentPlatform;
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: _resolveOptions());
  }
}
