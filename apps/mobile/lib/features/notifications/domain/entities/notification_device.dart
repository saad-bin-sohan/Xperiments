class NotificationDevice {
  const NotificationDevice({
    required this.deviceId,
    required this.token,
    required this.platform,
    required this.timezone,
    required this.notificationsEnabled,
    required this.updatedAt,
    this.appVersion,
  });

  final String deviceId;
  final String token;
  final String platform;
  final String timezone;
  final bool notificationsEnabled;
  final DateTime updatedAt;
  final String? appVersion;
}
