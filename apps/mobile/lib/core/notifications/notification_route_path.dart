import 'package:mobile/core/routing/route_paths.dart';
import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';

class NotificationRoutePath {
  const NotificationRoutePath._();

  static String toPath(AppNotificationRoute route) {
    return RoutePaths.experimentCheckin(route.experimentId, date: route.date);
  }
}
