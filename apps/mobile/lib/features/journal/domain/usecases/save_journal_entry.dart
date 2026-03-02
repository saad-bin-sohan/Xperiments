import 'package:mobile/features/journal/domain/entities/journal_entry_draft.dart';
import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';

class SaveJournalEntry {
  const SaveJournalEntry(this._repository);

  final JournalRepository _repository;

  Future<void> call({
    String? entryId,
    required JournalEntryDraft draft,
    required String userId,
  }) {
    return _repository.saveEntry(
      entryId: entryId,
      draft: draft,
      userId: userId,
    );
  }
}
