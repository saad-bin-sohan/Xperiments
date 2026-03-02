class JournalEntry {
  const JournalEntry({
    required this.id,
    required this.userId,
    required this.labId,
    required this.date,
    this.moodWords,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String labId;
  final DateTime date;
  final String? moodWords;
  final String body;
  final DateTime createdAt;
}
