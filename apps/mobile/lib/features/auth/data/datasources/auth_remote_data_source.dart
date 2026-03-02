import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/error/app_exception.dart';
import 'package:mobile/features/auth/data/models/auth_user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  bool _googleInitialized = false;

  Stream<AuthUserModel?> observeAuthState() {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      }
      return AuthUserModel.fromFirebaseUser(user);
    });
  }

  Future<AuthUserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AppException('Unable to sign in. Try again.');
      }

      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      throw AppException(error.message ?? 'Unable to sign in.');
    }
  }

  Future<AuthUserModel> signUpWithEmail({
    required String displayName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AppException('Unable to create account. Try again.');
      }

      await user.updateDisplayName(displayName.trim());
      await user.reload();
      final refreshedUser = _firebaseAuth.currentUser;
      if (refreshedUser == null) {
        throw const AppException('Unable to create account. Try again.');
      }

      return AuthUserModel.fromFirebaseUser(refreshedUser);
    } on FirebaseAuthException catch (error) {
      throw AppException(error.message ?? 'Unable to create account.');
    }
  }

  Future<AuthUserModel> signInWithGoogle() async {
    try {
      await _ensureGoogleInitialized();
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final user = authResult.user;
      if (user == null) {
        throw const AppException('Google sign-in failed. Try again.');
      }

      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (error) {
      throw AppException(error.message ?? 'Google sign-in failed.');
    } on GoogleSignInException catch (error) {
      throw AppException(error.description ?? 'Google sign-in failed.');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (_googleInitialized) {
      await _googleSignIn.signOut();
    }
  }

  bool get isSignedIn => _firebaseAuth.currentUser != null;

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) {
      return;
    }

    await _googleSignIn.initialize();
    _googleInitialized = true;
  }
}
