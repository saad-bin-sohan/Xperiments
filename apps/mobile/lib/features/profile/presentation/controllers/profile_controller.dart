import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
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
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(signOutUseCaseProvider).call();
    });
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(userRepositoryProvider).deleteCurrentUser();
      await ref.read(signOutUseCaseProvider).call();
    });
  }
}
