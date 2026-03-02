import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';

class WatchLabEntries {
  const WatchLabEntries(this._repository);

  final JournalRepository _repository;

  Stream<List<JournalEntry>> call(String userId, String labId) {
    return _repository.watchLabEntries(userId, labId);
  }
}
