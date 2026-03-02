import 'package:mobile/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  Future<AppNotificationRoute?> getInitialNotificationRoute() {
    return _remoteDataSource.getInitialNotificationRoute();
  }

  @override
  Future<void> initialize() {
    return _remoteDataSource.initialize();
  }

  @override
  Future<void> removeDeviceRegistration({required String userId}) {
    return _remoteDataSource.removeDeviceRegistration(userId: userId);
  }

  @override
  Future<void> requestPermissionIfNeeded() {
    return _remoteDataSource.requestPermissionIfNeeded();
  }

  @override
  Future<void> syncDeviceRegistration({
    required String userId,
    required bool notificationsEnabled,
  }) {
    return _remoteDataSource.syncDeviceRegistration(
      userId: userId,
      notificationsEnabled: notificationsEnabled,
    );
  }

  @override
  Stream<AppNotificationRoute> watchNotificationOpens() {
    return _remoteDataSource.watchNotificationOpens();
  }

  @override
  Stream<AppNotificationRoute> watchForegroundNotifications() {
    return _remoteDataSource.watchForegroundNotifications();
  }
}
