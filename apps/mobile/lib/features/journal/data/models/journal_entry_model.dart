import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry.dart';

class JournalEntryModel {
  const JournalEntryModel({
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

  factory JournalEntryModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    return JournalEntryModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      labId: data['labId'] as String? ?? '',
      date: _readDate(data['date']) ?? DateTime.now(),
      moodWords: data['moodWords'] as String?,
      body: data['body'] as String? ?? '',
      createdAt: _readDate(data['createdAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _readDate(Object? raw) {
    if (raw is Timestamp) {
      return raw.toDate();
    }
    if (raw is DateTime) {
      return raw;
    }
    return null;
  }
}

extension JournalEntryModelX on JournalEntryModel {
  JournalEntry toEntity() {
    return JournalEntry(
      id: id,
      userId: userId,
      labId: labId,
      date: date,
      moodWords: moodWords,
      body: body,
      createdAt: createdAt,
    );
  }
}
