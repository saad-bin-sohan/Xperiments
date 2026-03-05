import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/error/app_exception.dart';
import 'package:mobile/core/firebase/google_sign_in_client_ids.dart';
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
      throw AppException(
        _firebaseAuthMessage(error, fallback: 'Unable to sign in.'),
      );
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
      throw AppException(
        _firebaseAuthMessage(error, fallback: 'Unable to create account.'),
      );
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
      throw AppException(
        _firebaseAuthMessage(error, fallback: 'Google sign-in failed.'),
      );
    } on GoogleSignInException catch (error) {
      throw AppException(_googleSignInMessage(error));
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

    final String? serverClientId = GoogleSignInClientIds.forFlavor(Env.flavor);
    if (serverClientId == null) {
      final flavor = Env.flavor.id;
      throw AppException(
        'Google Sign-In server client ID is missing for FLAVOR=$flavor. '
        'Set GOOGLE_SERVER_CLIENT_ID or update android/app/google-services.json '
        'with a web OAuth client.',
      );
    }

    await _googleSignIn.initialize(serverClientId: serverClientId);
    _googleInitialized = true;
  }

  String _firebaseAuthMessage(
    FirebaseAuthException error, {
    required String fallback,
  }) {
    final code = error.code.toLowerCase();
    final message = error.message ?? '';
    final normalizedMessage = message.toLowerCase();

    if (code == 'operation-not-allowed') {
      return 'Enable Email/Password and Google in Firebase Authentication for '
          'this project.';
    }

    if (code == 'invalid-api-key' ||
        normalizedMessage.contains('api key not valid')) {
      return 'Firebase config mismatch: rebuild with matching Firebase options '
          'and android/app/google-services.json.';
    }

    return message.isNotEmpty ? message : fallback;
  }

  String _googleSignInMessage(GoogleSignInException error) {
    final description = error.description ?? '';
    final normalizedDescription = description.toLowerCase();

    if (normalizedDescription.contains('serverclientid must be provided')) {
      return 'Google Sign-In Android config is incomplete: missing server '
          'client ID. Ensure google-services for this FLAVOR includes a web '
          'OAuth client (client_type: 3), then rebuild.';
    }

    if (error.code == GoogleSignInExceptionCode.clientConfigurationError) {
      return 'Google Sign-In is misconfigured for this build. Verify package '
          'name, SHA fingerprints, and Firebase OAuth setup.';
    }

    return description.isNotEmpty ? description : 'Google sign-in failed.';
  }
}
