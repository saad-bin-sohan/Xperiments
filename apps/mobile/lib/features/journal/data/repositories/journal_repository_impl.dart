import 'package:mobile/features/journal/data/datasources/journal_remote_data_source.dart';
import 'package:mobile/features/journal/data/models/journal_entry_model.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry_draft.dart';
import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  const JournalRepositoryImpl(this._remoteDataSource);

  final JournalRemoteDataSource _remoteDataSource;

  @override
  Future<void> deleteEntry({required String userId, required String entryId}) {
    return _remoteDataSource.deleteEntry(userId: userId, entryId: entryId);
  }

  @override
  Future<void> saveEntry({
    String? entryId,
    required JournalEntryDraft draft,
    required String userId,
  }) {
    return _remoteDataSource.saveEntry(
      entryId: entryId,
      draft: draft,
      userId: userId,
    );
  }

  @override
  Future<List<JournalEntry>> searchLabEntries({
    required String userId,
    required String labId,
    required String query,
  }) {
    return _remoteDataSource
        .searchLabEntries(userId: userId, labId: labId, query: query)
        .then((models) {
          return models
              .map((JournalEntryModel model) => model.toEntity())
              .toList();
        });
  }

  @override
  Stream<List<JournalEntry>> watchLabEntries(String userId, String labId) {
    return _remoteDataSource.watchLabEntries(userId, labId).map((models) {
      return models.map((JournalEntryModel model) => model.toEntity()).toList();
    });
  }
}
