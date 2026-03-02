import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> updatePreferences(UserPreferencesPatch patch) async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;
    if (user == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(updatePreferencesUseCaseProvider)
          .call(userId: user.id, patch: patch);

      final currentPreferences = ref
          .read(currentUserPreferencesProvider)
          .asData
          ?.value;
      final notificationsEnabled =
          patch.notificationsEnabled ??
          currentPreferences?.notificationsEnabled ??
          true;

      await ref
          .read(syncDeviceRegistrationUseCaseProvider)
          .call(userId: user.id, notificationsEnabled: notificationsEnabled);
    });
  }

  Future<void> signOut() async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (user != null) {
        await ref
            .read(removeDeviceRegistrationUseCaseProvider)
            .call(userId: user.id);
      }
      await ref.read(signOutUseCaseProvider).call();
    });
  }

  Future<void> deleteAccount() async {
    final session = ref.read(authSessionProvider).asData?.value;
    final user = session?.user;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (user != null) {
        await ref
            .read(removeDeviceRegistrationUseCaseProvider)
            .call(userId: user.id);
      }
      await ref.read(userRepositoryProvider).deleteCurrentUser();
      await ref.read(signOutUseCaseProvider).call();
    });
  }
}
