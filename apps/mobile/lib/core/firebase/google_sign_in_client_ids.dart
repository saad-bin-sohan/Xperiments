import 'package:mobile/core/config/app_flavor.dart';

class GoogleSignInClientIds {
  const GoogleSignInClientIds._();

  static const String _defaultServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        '506602598766-nbv3puh70bsv05j98ij4lqjtsslasiac.apps.googleusercontent.com',
  );

  static String? forFlavor(AppFlavor flavor) {
    final normalized = _defaultServerClientId.trim();
    return normalized.isEmpty ? null : normalized;
  }
}
