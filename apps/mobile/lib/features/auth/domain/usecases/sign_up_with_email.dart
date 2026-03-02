import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmail {
  const SignUpWithEmail(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({
    required String displayName,
    required String email,
    required String password,
  }) {
    return _repository.signUpWithEmail(
      displayName: displayName,
      email: email,
      password: password,
    );
  }
}
