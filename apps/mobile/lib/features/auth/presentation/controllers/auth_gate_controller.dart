import 'package:mobile/core/error/app_exception.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_gate_controller.g.dart';

@riverpod
Future<void> authGateBootstrap(Ref ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;

  if (user == null || !session.isAuthenticated) {
    return;
  }

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
