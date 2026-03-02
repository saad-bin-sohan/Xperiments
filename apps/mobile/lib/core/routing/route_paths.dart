class RoutePaths {
  const RoutePaths._();

  static const String auth = '/auth';
  static const String experiments = '/experiments';
  static const String history = '/history';
  static const String gallery = '/gallery';
  static const String profile = '/profile';

  static const String labsNew = '/experiments/labs/new';
  static const String labDetailPattern = '/experiments/labs/:labId';
  static const String labEditPattern = '/experiments/labs/:labId/edit';
  static const String experimentNewPattern =
      '/experiments/labs/:labId/experiments/new';
  static const String experimentDetailPattern =
      '/experiments/experiments/:experimentId';

  static String labDetail(String labId) => '/experiments/labs/$labId';

  static String labEdit(String labId) => '/experiments/labs/$labId/edit';

  static String experimentNew(String labId) =>
      '/experiments/labs/$labId/experiments/new';

  static String experimentDetail(String experimentId) =>
      '/experiments/experiments/$experimentId';
}
