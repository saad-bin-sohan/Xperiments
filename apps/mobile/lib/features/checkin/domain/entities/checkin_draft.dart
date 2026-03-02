class CheckinDraft {
  const CheckinDraft({
    required this.experimentId,
    required this.date,
    this.moodWords,
    this.subtaskCompletions = const <String, bool>{},
    this.rating,
    this.photoFilePath,
    this.journalEntry,
    required this.isBackfill,
    required this.isRestDay,
  });

  final String experimentId;
  final DateTime date;
  final String? moodWords;
  final Map<String, bool> subtaskCompletions;
  final int? rating;
  final String? photoFilePath;
  final String? journalEntry;
  final bool isBackfill;
  final bool isRestDay;
}
