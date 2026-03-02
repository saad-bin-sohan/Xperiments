import 'package:mobile/features/auth/domain/entities/auth_user.dart';

abstract class UserRepository {
  Future<void> ensureUserDocument(AuthUser user);

  Stream<Map<String, dynamic>?> watchUserDocument(String userId);

  Future<bool> isUserDisabled(String userId);

  Future<void> deleteCurrentUser();
}
