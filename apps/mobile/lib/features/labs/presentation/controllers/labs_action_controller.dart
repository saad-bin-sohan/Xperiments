import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'labs_action_controller.g.dart';

@riverpod
class LabsActionController extends _$LabsActionController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<Lab?> createLab(LabDraft draft) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return null;
    }

    state = const AsyncLoading();
    final result = await AsyncValue.guard<Lab?>(() async {
      return ref
          .read(createLabUseCaseProvider)
          .call(userId: user.id, draft: draft);
    });
    state = result.whenData((_) {});
    return result.asData?.value;
  }

  Future<void> updateLab({
    required String labId,
    required LabDraft draft,
  }) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(updateLabUseCaseProvider)
          .call(labId: labId, userId: user.id, draft: draft);
    });
  }

  Future<LabDeletionCheck> deleteLabIfAllowed(String labId) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return const LabDeletionCheck(canDelete: false, reason: 'Not signed in.');
    }

    state = const AsyncLoading();

    final result = await AsyncValue.guard<LabDeletionCheck>(() async {
      final check = await ref
          .read(canDeleteLabUseCaseProvider)
          .call(labId: labId, userId: user.id);
      if (!check.canDelete) {
        return check;
      }
      await ref
          .read(deleteLabUseCaseProvider)
          .call(labId: labId, userId: user.id);
      return check;
    });

    state = result.whenData((_) {});

    return result.when(
      data: (value) => value,
      loading: () => const LabDeletionCheck(canDelete: false),
      error: (Object error, StackTrace _) =>
          LabDeletionCheck(canDelete: false, reason: error.toString()),
    );
  }
}
