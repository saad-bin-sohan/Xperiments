import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/journal/data/datasources/journal_remote_data_source.dart';
import 'package:mobile/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry.dart';
import 'package:mobile/features/journal/domain/repositories/journal_repository.dart';
import 'package:mobile/features/journal/domain/usecases/delete_journal_entry.dart';
import 'package:mobile/features/journal/domain/usecases/save_journal_entry.dart';
import 'package:mobile/features/journal/domain/usecases/search_lab_entries.dart';
import 'package:mobile/features/journal/domain/usecases/watch_lab_entries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_providers.g.dart';

@Riverpod(keepAlive: true)
JournalRemoteDataSource journalRemoteDataSource(Ref ref) {
  return JournalRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
JournalRepository journalRepository(Ref ref) {
  return JournalRepositoryImpl(ref.watch(journalRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
WatchLabEntries watchLabEntriesUseCase(Ref ref) {
  return WatchLabEntries(ref.watch(journalRepositoryProvider));
}

@Riverpod(keepAlive: true)
SaveJournalEntry saveJournalEntryUseCase(Ref ref) {
  return SaveJournalEntry(ref.watch(journalRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteJournalEntry deleteJournalEntryUseCase(Ref ref) {
  return DeleteJournalEntry(ref.watch(journalRepositoryProvider));
}

@Riverpod(keepAlive: true)
SearchLabEntries searchLabEntriesUseCase(Ref ref) {
  return SearchLabEntries(ref.watch(journalRepositoryProvider));
}

@riverpod
Stream<List<JournalEntry>> labJournalEntries(Ref ref, String labId) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;
  if (user == null) {
    return Stream<List<JournalEntry>>.value(const <JournalEntry>[]);
  }

  return ref.watch(watchLabEntriesUseCaseProvider).call(user.id, labId);
}

@riverpod
Future<List<JournalEntry>> labJournalSearch(
  Ref ref, {
  required String labId,
  required String query,
}) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;
  if (user == null || query.trim().isEmpty) {
    return const <JournalEntry>[];
  }

  return ref
      .watch(searchLabEntriesUseCaseProvider)
      .call(userId: user.id, labId: labId, query: query);
}
