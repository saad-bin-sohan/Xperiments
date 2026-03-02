import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';

class DeleteJournalEntry {
  const DeleteJournalEntry(this._repository);

  final JournalRepository _repository;

  Future<void> call({required String userId, required String entryId}) {
    return _repository.deleteEntry(userId: userId, entryId: entryId);
  }
}
