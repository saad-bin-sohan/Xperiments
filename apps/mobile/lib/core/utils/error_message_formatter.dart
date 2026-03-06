class AppErrorMessageFormatter {
  const AppErrorMessageFormatter._();

  static const String _fallbackMessage =
      'Something went wrong. Please try again.';

  static String forSnackBar(
    Object error, {
    int maxLength = 160,
    String fallbackMessage = _fallbackMessage,
  }) {
    final raw = error.toString().trim();
    if (raw.isEmpty) {
      return fallbackMessage;
    }

    var firstLine = raw.split('\n').first.trim();
    if (firstLine.isEmpty) {
      return fallbackMessage;
    }

    if (firstLine.length <= maxLength) {
      return firstLine;
    }

    final truncatedLength = maxLength > 3 ? maxLength - 3 : maxLength;
    firstLine = firstLine.substring(0, truncatedLength).trimRight();
    return '$firstLine...';
  }
}
