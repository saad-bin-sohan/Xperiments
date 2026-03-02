import 'package:mobile/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<void> ensureUserDocument(AuthUser user) {
    return _remoteDataSource.ensureUserDocument(user);
  }

  @override
  Stream<Map<String, dynamic>?> watchUserDocument(String userId) {
    return _remoteDataSource.watchUserDocument(userId);
  }

  @override
  Future<bool> isUserDisabled(String userId) {
    return _remoteDataSource.isUserDisabled(userId);
  }

  @override
  Future<void> deleteCurrentUser() {
    return _remoteDataSource.deleteCurrentUser();
  }
}
