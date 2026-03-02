import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';

abstract class NotificationsRepository {
  Future<void> initialize();

  Future<void> requestPermissionIfNeeded();

  Future<void> syncDeviceRegistration({
    required String userId,
    required bool notificationsEnabled,
  });

  Future<void> removeDeviceRegistration({required String userId});

  Stream<AppNotificationRoute> watchNotificationOpens();

  Stream<AppNotificationRoute> watchForegroundNotifications();

  Future<AppNotificationRoute?> getInitialNotificationRoute();
}
