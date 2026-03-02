class AppTextUtils {
  const AppTextUtils._();

  static List<String> tokenize(String input) {
    return input
        .toLowerCase()
        .split(RegExp(r'[^a-z0-9]+'))
        .map((token) => token.trim())
        .where((token) => token.length > 1)
        .toList();
  }

  static List<String> moodTokens(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const <String>[];
    }

    return raw
        .toLowerCase()
        .split(RegExp(r'[\s,]+'))
        .map((token) => token.trim())
        .where((token) => token.length > 1)
        .toList();
  }

  static String snippetForMatch(String source, String query) {
    if (source.isEmpty) {
      return '';
    }

    final normalizedSource = source.toLowerCase();
    final normalizedQuery = query.toLowerCase().trim();
    final index = normalizedSource.indexOf(normalizedQuery);

    if (index < 0) {
      final compact = source.replaceAll(RegExp(r'\s+'), ' ').trim();
      if (compact.length <= 120) {
        return compact;
      }
      return '${compact.substring(0, 117)}...';
    }

    final start = (index - 36).clamp(0, source.length);
    final end = (index + normalizedQuery.length + 60).clamp(0, source.length);
    final segment = source
        .substring(start, end)
        .replaceAll(RegExp(r'\s+'), ' ');

    final prefix = start > 0 ? '...' : '';
    final suffix = end < source.length ? '...' : '';
    return '$prefix${segment.trim()}$suffix';
  }
}
