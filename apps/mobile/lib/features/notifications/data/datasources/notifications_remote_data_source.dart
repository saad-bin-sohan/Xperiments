import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/notifications/notification_route_parser.dart';
import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NotificationsRemoteDataSource {
  NotificationsRemoteDataSource({
    required FirebaseFirestore firestore,
    required FirebaseMessaging messaging,
  }) : _firestore = firestore,
       _messaging = messaging;

  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;

  final StreamController<AppNotificationRoute> _openRoutesController =
      StreamController<AppNotificationRoute>.broadcast();
  final StreamController<AppNotificationRoute> _foregroundRoutesController =
      StreamController<AppNotificationRoute>.broadcast();

  StreamSubscription<RemoteMessage>? _openedSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<String>? _tokenRefreshSubscription;

  bool _initialized = false;
  String? _currentUserId;
  bool _currentNotificationsEnabled = true;

  DocumentReference<Map<String, dynamic>> _userDoc(String userId) {
    return _firestore.collection(FirebaseCollections.users).doc(userId);
  }

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    _openedSubscription = FirebaseMessaging.onMessageOpenedApp.listen((
      message,
    ) {
      final route = NotificationRouteParser.fromMessageData(message.data);
      if (route != null) {
        _openRoutesController.add(route);
      }
    });

    _foregroundSubscription = FirebaseMessaging.onMessage.listen((message) {
      final route = NotificationRouteParser.fromMessageData(message.data);
      if (route != null) {
        _foregroundRoutesController.add(route);
      }
    });

    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((newToken) {
      final userId = _currentUserId;
      if (userId == null || newToken.trim().isEmpty) {
        return;
      }
      unawaited(
        _syncDeviceDocument(
          userId: userId,
          token: newToken,
          notificationsEnabled: _currentNotificationsEnabled,
        ),
      );
    });
  }

  Future<void> requestPermissionIfNeeded() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<void> syncDeviceRegistration({
    required String userId,
    required bool notificationsEnabled,
  }) async {
    _currentUserId = userId;
    _currentNotificationsEnabled = notificationsEnabled;

    final token = await _messaging.getToken();
    if (token == null || token.trim().isEmpty) {
      return;
    }

    await _syncDeviceDocument(
      userId: userId,
      token: token,
      notificationsEnabled: notificationsEnabled,
    );
  }

  Future<void> removeDeviceRegistration({required String userId}) async {
    final token = await _messaging.getToken();
    if (token == null || token.trim().isEmpty) {
      _currentUserId = null;
      return;
    }

    await _userDoc(
      userId,
    ).collection(FirebaseCollections.devices).doc(token).delete();

    _currentUserId = null;
  }

  Stream<AppNotificationRoute> watchNotificationOpens() {
    return _openRoutesController.stream;
  }

  Stream<AppNotificationRoute> watchForegroundNotifications() {
    return _foregroundRoutesController.stream;
  }

  Future<AppNotificationRoute?> getInitialNotificationRoute() async {
    final message = await _messaging.getInitialMessage();
    if (message == null) {
      return null;
    }

    return NotificationRouteParser.fromMessageData(message.data);
  }

  Future<void> _syncDeviceDocument({
    required String userId,
    required String token,
    required bool notificationsEnabled,
  }) async {
    final timezone = await _safeTimezone();
    final version = await _safeAppVersion();

    await _userDoc(userId).set(<String, dynamic>{
      'preferences': <String, dynamic>{'timezone': timezone},
    }, SetOptions(merge: true));

    final payload = <String, dynamic>{
      'deviceId': token,
      'token': token,
      'platform': _platformName,
      'timezone': timezone,
      'notificationsEnabled': notificationsEnabled,
      'updatedAt': FieldValue.serverTimestamp(),
      'appVersion': version,
    };

    await _userDoc(userId)
        .collection(FirebaseCollections.devices)
        .doc(token)
        .set(payload, SetOptions(merge: true));
  }

  Future<String> _safeTimezone() async {
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      if (timezone.trim().isEmpty) {
        return 'UTC';
      }
      return timezone;
    } catch (_) {
      return 'UTC';
    }
  }

  Future<String?> _safeAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (_) {
      return null;
    }
  }

  String get _platformName {
    if (Platform.isAndroid) {
      return 'android';
    }
    if (Platform.isIOS) {
      return 'ios';
    }
    return Platform.operatingSystem;
  }

  Future<void> dispose() async {
    await _openedSubscription?.cancel();
    await _foregroundSubscription?.cancel();
    await _tokenRefreshSubscription?.cancel();
    await _openRoutesController.close();
    await _foregroundRoutesController.close();
  }
}
