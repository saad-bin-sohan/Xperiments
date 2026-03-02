import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/journal/domain/entities/journal_entry_draft.dart';
import 'package:mobile/features/journal/presentation/providers/journal_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_controller.g.dart';

@riverpod
class JournalController extends _$JournalController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> saveEntry({
    required String labId,
    String? entryId,
    required DateTime date,
    String? moodWords,
    required String body,
  }) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(saveJournalEntryUseCaseProvider)
          .call(
            entryId: entryId,
            userId: user.id,
            draft: JournalEntryDraft(
              labId: labId,
              date: date,
              moodWords: moodWords,
              body: body,
            ),
          );

      ref.invalidate(labJournalEntriesProvider(labId));
    });
  }

  Future<void> deleteEntry({
    required String labId,
    required String entryId,
  }) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(deleteJournalEntryUseCaseProvider)
          .call(userId: user.id, entryId: entryId);

      ref.invalidate(labJournalEntriesProvider(labId));
    });
  }
}
