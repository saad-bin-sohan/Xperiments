enum AppNotificationRouteType { nudge, friendCheckin, widgetCheckin }

class AppNotificationRoute {
  const AppNotificationRoute({
    required this.type,
    required this.experimentId,
    this.date,
  });

  final AppNotificationRouteType type;
  final String experimentId;
  final DateTime? date;
}
