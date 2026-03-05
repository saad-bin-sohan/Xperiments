import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app.dart';
import 'package:mobile/core/diagnostics/diagnostic_log.dart';
import 'package:mobile/core/diagnostics/diagnostic_logger.dart';
import 'package:mobile/core/firebase/firebase_initializer.dart';
import 'package:mobile/core/notifications/firebase_messaging_background_handler.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseInitializer.initialize();

  // --- Debug diagnostics hooks ---
  if (kDebugMode) {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      DiagnosticLogger.instance.log(
        LogLevel.error,
        'Flutter',
        details.exceptionAsString(),
        details.stack,
      );
      // Forward to the original handler so assertions still fire.
      originalOnError?.call(details);
    };
  }

  final List<ProviderObserver> observers = <ProviderObserver>[
    if (kDebugMode) _DiagnosticProviderObserver(),
  ];

  runZonedGuarded(
    () => runApp(
      ProviderScope(
        observers: observers,
        child: const XperimentsApp(),
      ),
    ),
    (Object error, StackTrace stackTrace) {
      if (kDebugMode) {
        DiagnosticLogger.instance.log(
          LogLevel.fatal,
          'Zone',
          error.toString(),
          stackTrace,
        );
      }

      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'bootstrap',
        ),
      );
    },
  );
}

/// Riverpod observer that captures provider errors into the diagnostic log.
base class _DiagnosticProviderObserver extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    DiagnosticLogger.instance.log(
      LogLevel.error,
      'Provider:${context.provider.name ?? context.provider.runtimeType}',
      error.toString(),
      stackTrace,
    );
  }
}
