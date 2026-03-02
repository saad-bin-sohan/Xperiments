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
  static const String experimentCheckinPattern =
      '/experiments/experiments/:experimentId/checkin';
  static const String historyExperimentDetailPattern =
      '/history/experiments/:experimentId';
  static const String galleryTemplatePattern = '/gallery/templates/:templateId';

  static String labDetail(String labId) => '/experiments/labs/$labId';

  static String labEdit(String labId) => '/experiments/labs/$labId/edit';

  static String experimentNew(String labId) =>
      '/experiments/labs/$labId/experiments/new';

  static String experimentDetail(String experimentId) =>
      '/experiments/experiments/$experimentId';

  static String experimentCheckin(String experimentId, {DateTime? date}) {
    final path = '/experiments/experiments/$experimentId/checkin';
    if (date == null) {
      return path;
    }
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$path?date=${date.year}-$month-$day';
  }

  static String historyExperimentDetail(String experimentId) =>
      '/history/experiments/$experimentId';

  static String galleryTemplate(String templateId) =>
      '/gallery/templates/$templateId';
}
