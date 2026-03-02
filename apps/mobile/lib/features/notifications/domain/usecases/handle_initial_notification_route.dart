import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class HandleInitialNotificationRoute {
  const HandleInitialNotificationRoute(this._repository);

  final NotificationsRepository _repository;

  Future<AppNotificationRoute?> call() {
    return _repository.getInitialNotificationRoute();
  }
}
