import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/features/auth/data/models/user_preferences_model.dart';
import 'package:mobile/features/auth/domain/entities/auth_user.dart';

class UserRemoteDataSource {
  const UserRemoteDataSource({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  Future<void> ensureUserDocument(AuthUser user) async {
    final docRef = _firestore
        .collection(FirebaseCollections.users)
        .doc(user.id);
    final snapshot = await docRef.get();

    final data = <String, dynamic>{
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoUrl,
      'isAdmin': false,
      'disabled': false,
      'createdAt': FieldValue.serverTimestamp(),
      'preferences': const UserPreferencesModel().toMap(),
    };

    if (!snapshot.exists) {
      await docRef.set(data);
      return;
    }

    await docRef.set(<String, dynamic>{
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoUrl,
    }, SetOptions(merge: true));
  }

  Stream<Map<String, dynamic>?> watchUserDocument(String userId) {
    return _firestore
        .collection(FirebaseCollections.users)
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          return snapshot.data();
        });
  }

  Future<bool> isUserDisabled(String userId) async {
    final snapshot = await _firestore
        .collection(FirebaseCollections.users)
        .doc(userId)
        .get();

    final data = snapshot.data();
    if (data == null) {
      return false;
    }

    return data['disabled'] == true;
  }

  Future<void> deleteCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return;
    }
    await user.delete();
  }
}
