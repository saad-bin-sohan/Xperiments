import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';

part 'auth_user_model.freezed.dart';

@freezed
abstract class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
  }) = _AuthUserModel;

  factory AuthUserModel.fromFirebaseUser(firebase_auth.User user) {
    final email = user.email ?? '';
    final fallbackName = email.isEmpty ? 'User' : email.split('@').first;

    return AuthUserModel(
      id: user.uid,
      email: email,
      displayName: (user.displayName ?? '').trim().isEmpty
          ? fallbackName
          : user.displayName!.trim(),
      photoUrl: user.photoURL,
    );
  }
}

extension AuthUserModelX on AuthUserModel {
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
