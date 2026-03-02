class CheckinRecord {
  const CheckinRecord({
    required this.id,
    required this.experimentId,
    required this.date,
    required this.completed,
    this.moodWords,
    this.subtaskCompletions = const <String, bool>{},
    this.rating,
    this.photoUrl,
    this.journalEntry,
    required this.isBackfill,
    required this.isRestDay,
    required this.createdAt,
  });

  final String id;
  final String experimentId;
  final DateTime date;
  final bool completed;
  final String? moodWords;
  final Map<String, bool> subtaskCompletions;
  final int? rating;
  final String? photoUrl;
  final String? journalEntry;
  final bool isBackfill;
  final bool isRestDay;
  final DateTime createdAt;
}
