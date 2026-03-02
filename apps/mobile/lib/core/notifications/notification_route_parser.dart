import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';

class NotificationRouteParser {
  const NotificationRouteParser._();

  static AppNotificationRoute? fromMessageData(Map<String, dynamic> data) {
    final typeRaw = data['type']?.toString().trim();
    final experimentId = data['experimentId']?.toString().trim();
    if (typeRaw == null || typeRaw.isEmpty) {
      return null;
    }
    if (experimentId == null || experimentId.isEmpty) {
      return null;
    }

    final type = switch (typeRaw) {
      'nudge' => AppNotificationRouteType.nudge,
      'friend_checkin' => AppNotificationRouteType.friendCheckin,
      'widget_checkin' => AppNotificationRouteType.widgetCheckin,
      _ => null,
    };

    if (type == null) {
      return null;
    }

    final dateRaw = data['date']?.toString().trim();
    final date = dateRaw == null || dateRaw.isEmpty
        ? null
        : DateTime.tryParse(dateRaw);

    return AppNotificationRoute(
      type: type,
      experimentId: experimentId,
      date: date,
    );
  }

  static AppNotificationRoute? fromWidgetUri(Uri? uri) {
    if (uri == null) {
      return null;
    }

    final route = uri.queryParameters['route'];
    if (route == null || route.isEmpty) {
      return null;
    }

    final parsed = Uri.tryParse(route);
    if (parsed == null) {
      return null;
    }

    if (parsed.pathSegments.length < 4) {
      return null;
    }

    if (parsed.pathSegments[0] != 'experiments' ||
        parsed.pathSegments[1] != 'experiments' ||
        parsed.pathSegments[3] != 'checkin') {
      return null;
    }

    final experimentId = parsed.pathSegments[2];
    final dateRaw = parsed.queryParameters['date'];

    return AppNotificationRoute(
      type: AppNotificationRouteType.widgetCheckin,
      experimentId: experimentId,
      date: dateRaw == null ? null : DateTime.tryParse(dateRaw),
    );
  }
}
