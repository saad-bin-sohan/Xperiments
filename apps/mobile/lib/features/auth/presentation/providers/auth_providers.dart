import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mobile/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/data/repositories/user_repository_impl.dart';
import 'package:mobile/features/auth/domain/entities/auth_session.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/auth/domain/repositories/user_repository.dart';
import 'package:mobile/features/auth/domain/usecases/ensure_user_document.dart';
import 'package:mobile/features/auth/domain/usecases/observe_auth_state.dart';
import 'package:mobile/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:mobile/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:mobile/features/auth/domain/usecases/sign_out.dart';
import 'package:mobile/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSource(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
}

@Riverpod(keepAlive: true)
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  return UserRemoteDataSource(
    firestore: ref.watch(firestoreProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
  );
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
SignInWithEmail signInWithEmailUseCase(Ref ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
SignUpWithEmail signUpWithEmailUseCase(Ref ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
SignInWithGoogle signInWithGoogleUseCase(Ref ref) {
  return SignInWithGoogle(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
SignOut signOutUseCase(Ref ref) {
  return SignOut(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
EnsureUserDocument ensureUserDocumentUseCase(Ref ref) {
  return EnsureUserDocument(ref.watch(userRepositoryProvider));
}

@Riverpod(keepAlive: true)
ObserveAuthState observeAuthStateUseCase(Ref ref) {
  return ObserveAuthState(ref.watch(authRepositoryProvider));
}

@riverpod
Stream<AuthSession> authSession(Ref ref) {
  return ref.watch(observeAuthStateUseCaseProvider).call();
}

@riverpod
AuthUser? currentAuthUser(Ref ref) {
  return ref.watch(authSessionProvider).asData?.value.user;
}

@riverpod
User? firebaseCurrentUser(Ref ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
}
