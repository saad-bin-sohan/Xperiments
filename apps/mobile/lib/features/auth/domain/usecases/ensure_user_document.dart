import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/domain/repositories/user_repository.dart';

class EnsureUserDocument {
  const EnsureUserDocument(this._repository);

  final UserRepository _repository;

  Future<void> call(AuthUser user) {
    return _repository.ensureUserDocument(user);
  }
}
