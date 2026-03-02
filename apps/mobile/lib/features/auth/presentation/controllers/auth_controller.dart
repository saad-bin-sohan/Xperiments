import 'package:mobile/core/error/app_exception.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> submitWithEmail({
    required bool isSignUp,
    required String displayName,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final AuthUser user;

      if (isSignUp) {
        user = await ref
            .read(signUpWithEmailUseCaseProvider)
            .call(displayName: displayName, email: email, password: password);
      } else {
        user = await ref
            .read(signInWithEmailUseCaseProvider)
            .call(email: email, password: password);
      }

      await _postAuthBootstrap(user);
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final user = await ref.read(signInWithGoogleUseCaseProvider).call();
      await _postAuthBootstrap(user);
    });
  }

  Future<void> _postAuthBootstrap(AuthUser user) async {
    await ref.read(ensureUserDocumentUseCaseProvider).call(user);

    final bool disabled = await ref
        .read(userRepositoryProvider)
        .isUserDisabled(user.id);
    if (disabled) {
      await ref.read(signOutUseCaseProvider).call();
      throw const DisabledAccountException();
    }

    await ref.read(ensureDefaultLabExistsUseCaseProvider).call(user.id);
  }
}
