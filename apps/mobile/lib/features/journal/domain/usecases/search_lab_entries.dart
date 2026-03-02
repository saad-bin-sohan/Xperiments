import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';

class SearchLabEntries {
  const SearchLabEntries(this._repository);

  final JournalRepository _repository;

  Future<List<JournalEntry>> call({
    required String userId,
    required String labId,
    required String query,
  }) {
    return _repository.searchLabEntries(
      userId: userId,
      labId: labId,
      query: query,
    );
  }
}
