import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/core/utils/text_utils.dart';
import 'package:mobile/features/journal/data/models/journal_entry_model.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry_draft.dart';

class JournalRemoteDataSource {
  const JournalRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _journalCollection {
    return _firestore.collection(FirebaseCollections.journalEntries);
  }

  Stream<List<JournalEntryModel>> watchLabEntries(String userId, String labId) {
    return _journalCollection
        .where('userId', isEqualTo: userId)
        .where('labId', isEqualTo: labId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => JournalEntryModel.fromDoc(doc))
              .toList();
        });
  }

  Future<void> saveEntry({
    String? entryId,
    required JournalEntryDraft draft,
    required String userId,
  }) async {
    final payload = <String, dynamic>{
      'userId': userId,
      'labId': draft.labId,
      'date': AppDateUtils.startOfDay(draft.date),
      'moodWords': _nullable(draft.moodWords),
      'body': draft.body.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    if (entryId == null || entryId.trim().isEmpty) {
      await _journalCollection.add(payload);
      return;
    }

    await _journalCollection.doc(entryId).set(payload, SetOptions(merge: true));
  }

  Future<void> deleteEntry({required String userId, required String entryId}) {
    return _journalCollection.doc(entryId).delete();
  }

  Future<List<JournalEntryModel>> searchLabEntries({
    required String userId,
    required String labId,
    required String query,
  }) async {
    final tokens = AppTextUtils.tokenize(query);
    if (tokens.isEmpty) {
      return const <JournalEntryModel>[];
    }

    final snapshot = await _journalCollection
        .where('userId', isEqualTo: userId)
        .where('labId', isEqualTo: labId)
        .orderBy('date', descending: true)
        .get();

    final entries = snapshot.docs.map((doc) => JournalEntryModel.fromDoc(doc));

    return entries.where((entry) {
      final haystack = '${entry.body} ${entry.moodWords ?? ''}'.toLowerCase();
      for (final token in tokens) {
        if (!haystack.contains(token)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  String? _nullable(String? input) {
    final trimmed = input?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
