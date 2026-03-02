import 'package:mobile/core/config/app_flavor.dart';

class Env {
  const Env._();

  static const String _flavorValue = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static AppFlavor get flavor => AppFlavor.fromValue(_flavorValue);
}
