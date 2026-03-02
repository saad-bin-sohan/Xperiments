import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class WatchForegroundNotifications {
  const WatchForegroundNotifications(this._repository);

  final NotificationsRepository _repository;

  Stream<AppNotificationRoute> call() {
    return _repository.watchForegroundNotifications();
  }
}
