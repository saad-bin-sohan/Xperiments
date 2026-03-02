enum AppFlavor {
  dev,
  prod;

  static AppFlavor fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'prod':
        return AppFlavor.prod;
      case 'dev':
      default:
        return AppFlavor.dev;
    }
  }

  String get id {
    switch (this) {
      case AppFlavor.dev:
        return 'dev';
      case AppFlavor.prod:
        return 'prod';
    }
  }
}
