enum HistorySourceType {
  experimentName,
  finalReflection,
  lessonsLearned,
  checkinNote,
  journalEntry,
}

class HistorySearchResult {
  const HistorySearchResult({
    required this.experimentId,
    required this.title,
    required this.snippet,
    required this.sourceType,
    this.matchedDate,
  });

  final String experimentId;
  final String title;
  final String snippet;
  final HistorySourceType sourceType;
  final DateTime? matchedDate;
}
