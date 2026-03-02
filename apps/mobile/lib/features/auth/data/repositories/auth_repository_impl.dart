import 'package:mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mobile/features/auth/data/models/auth_user_model.dart';
import 'package:mobile/features/auth/domain/entities/auth_session.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Stream<AuthSession> observeAuthState() {
    return _remoteDataSource.observeAuthState().map((model) {
      if (model == null) {
        return AuthSession.unauthenticated();
      }
      return AuthSession.authenticated(_toEntity(model));
    });
  }

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final model = await _remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    return _toEntity(model);
  }

  @override
  Future<AuthUser> signUpWithEmail({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final model = await _remoteDataSource.signUpWithEmail(
      displayName: displayName,
      email: email,
      password: password,
    );
    return _toEntity(model);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    final model = await _remoteDataSource.signInWithGoogle();
    return _toEntity(model);
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  bool get isSignedIn => _remoteDataSource.isSignedIn;

  AuthUser _toEntity(AuthUserModel model) {
    return AuthUser(
      id: model.id,
      email: model.email,
      displayName: model.displayName,
      photoUrl: model.photoUrl,
    );
  }
}
