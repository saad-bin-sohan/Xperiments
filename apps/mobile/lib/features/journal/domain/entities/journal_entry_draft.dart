class JournalEntryDraft {
  const JournalEntryDraft({
    required this.labId,
    required this.date,
    this.moodWords,
    required this.body,
  });

  final String labId;
  final DateTime date;
  final String? moodWords;
  final String body;
}
