import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/features/profile/data/models/user_preferences_model.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';

class PreferencesRemoteDataSource {
  const PreferencesRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _userDoc(String userId) {
    return _firestore.collection(FirebaseCollections.users).doc(userId);
  }

  Stream<UserPreferencesModel> watchPreferences(String userId) {
    return _userDoc(userId).snapshots().map((
      DocumentSnapshot<Map<String, dynamic>> snapshot,
    ) {
      final data = snapshot.data();
      if (data == null) {
        return const UserPreferencesModel();
      }

      final preferences = data['preferences'] as Map<String, dynamic>?;
      if (preferences == null) {
        return const UserPreferencesModel();
      }

      return UserPreferencesModel.fromMap(
        Map<String, dynamic>.from(preferences),
      );
    });
  }

  Future<UserPreferencesModel> getPreferences(String userId) async {
    final snapshot = await _userDoc(userId).get();
    final data = snapshot.data();
    if (data == null) {
      return const UserPreferencesModel();
    }

    final preferences = data['preferences'] as Map<String, dynamic>?;
    if (preferences == null) {
      return const UserPreferencesModel();
    }

    return UserPreferencesModel.fromMap(Map<String, dynamic>.from(preferences));
  }

  Future<void> updatePreferences({
    required String userId,
    required UserPreferencesPatch patch,
  }) async {
    final Map<String, dynamic> serializedPatch = <String, dynamic>{};

    if (patch.theme != null) {
      serializedPatch['theme'] = appThemePreferenceToString(patch.theme!);
    }
    if (patch.notificationsEnabled != null) {
      serializedPatch['notificationsEnabled'] = patch.notificationsEnabled;
    }
    if (patch.nudgeDaysThreshold != null) {
      serializedPatch['nudgeDaysThreshold'] = patch.nudgeDaysThreshold;
    }
    if (patch.friendAccountabilityEnabled != null) {
      serializedPatch['friendAccountabilityEnabled'] =
          patch.friendAccountabilityEnabled;
    }
    if (patch.friendEmails != null) {
      serializedPatch['friendEmails'] = patch.friendEmails;
    }
    if (patch.journalEnabled != null) {
      serializedPatch['journalEnabled'] = patch.journalEnabled;
    }
    if (patch.interferenceLogEnabled != null) {
      serializedPatch['interferenceLogEnabled'] = patch.interferenceLogEnabled;
    }
    if (patch.passFailUiEnabled != null) {
      serializedPatch['passFailUiEnabled'] = patch.passFailUiEnabled;
    }

    if (serializedPatch.isEmpty) {
      return;
    }

    await _userDoc(userId).set(<String, dynamic>{
      'preferences': serializedPatch,
    }, SetOptions(merge: true));
  }
}
