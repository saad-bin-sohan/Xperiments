import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry_draft.dart';

abstract class JournalRepository {
  Stream<List<JournalEntry>> watchLabEntries(String userId, String labId);

  Future<void> saveEntry({
    String? entryId,
    required JournalEntryDraft draft,
    required String userId,
  });

  Future<void> deleteEntry({required String userId, required String entryId});

  Future<List<JournalEntry>> searchLabEntries({
    required String userId,
    required String labId,
    required String query,
  });
}
