import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app.dart';
import 'package:mobile/core/firebase/firebase_initializer.dart';
import 'package:mobile/core/notifications/firebase_messaging_background_handler.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseInitializer.initialize();

  runZonedGuarded(() => runApp(const ProviderScope(child: XperimentsApp())), (
    Object error,
    StackTrace stackTrace,
  ) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'bootstrap',
      ),
    );
  });
}
