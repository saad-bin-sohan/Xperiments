import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';

class CheckinModel {
  const CheckinModel({
    required this.id,
    required this.experimentId,
    required this.date,
    required this.completed,
    this.moodWords,
    required this.subtaskCompletions,
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

  factory CheckinModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    required String experimentId,
  }) {
    final data = doc.data() ?? <String, dynamic>{};

    return CheckinModel(
      id: doc.id,
      experimentId: experimentId,
      date: _readDate(data['date']) ?? DateTime.now(),
      completed: data['completed'] == true,
      moodWords: data['moodWords'] as String?,
      subtaskCompletions: _readSubtaskCompletions(data['subtaskCompletions']),
      rating: (data['rating'] as num?)?.toInt(),
      photoUrl: data['photoURL'] as String?,
      journalEntry: data['journalEntry'] as String?,
      isBackfill: data['isBackfill'] == true,
      isRestDay: data['isRestDay'] == true,
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

  static Map<String, bool> _readSubtaskCompletions(Object? raw) {
    if (raw is! Map) {
      return const <String, bool>{};
    }

    final parsed = <String, bool>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      if (key is! String) {
        continue;
      }
      parsed[key] = entry.value == true;
    }
    return parsed;
  }
}

extension CheckinModelX on CheckinModel {
  CheckinRecord toEntity() {
    return CheckinRecord(
      id: id,
      experimentId: experimentId,
      date: date,
      completed: completed,
      moodWords: moodWords,
      subtaskCompletions: subtaskCompletions,
      rating: rating,
      photoUrl: photoUrl,
      journalEntry: journalEntry,
      isBackfill: isBackfill,
      isRestDay: isRestDay,
      createdAt: createdAt,
    );
  }
}
