import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';

part 'auth_session.freezed.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required AuthUser? user,
    required bool isAuthenticated,
  }) = _AuthSession;

  factory AuthSession.authenticated(AuthUser user) {
    return AuthSession(user: user, isAuthenticated: true);
  }

  factory AuthSession.unauthenticated() {
    return const AuthSession(user: null, isAuthenticated: false);
  }
}
