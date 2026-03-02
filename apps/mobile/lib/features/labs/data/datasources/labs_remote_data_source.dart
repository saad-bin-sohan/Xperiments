import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/features/labs/data/models/lab_model.dart';
import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';

class LabsRemoteDataSource {
  const LabsRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _labsCollection {
    return _firestore.collection(FirebaseCollections.labs);
  }

  CollectionReference<Map<String, dynamic>> get _experimentsCollection {
    return _firestore.collection(FirebaseCollections.experiments);
  }

  Future<void> ensureDefaultLabExists(String userId) async {
    final existing = await _labsCollection
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      return;
    }

    await _labsCollection.add(<String, dynamic>{
      'userId': userId,
      'name': kDefaultLabName,
      'description': null,
      'iconId': kDefaultLabIconId,
      'colorHex': kDefaultLabColorHex,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<LabModel>> watchUserLabs(String userId) {
    return _labsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((
            QueryDocumentSnapshot<Map<String, dynamic>> doc,
          ) {
            return LabModel.fromDoc(doc);
          }).toList();
        });
  }

  Future<LabModel> createLab({
    required String userId,
    required LabDraft draft,
  }) async {
    final doc = await _labsCollection.add(<String, dynamic>{
      'userId': userId,
      'name': draft.name,
      'description': draft.description,
      'iconId': draft.iconId,
      'colorHex': draft.colorHex,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final snapshot = await doc.get();
    return LabModel.fromDoc(snapshot);
  }

  Future<void> updateLab({
    required String labId,
    required String userId,
    required LabDraft draft,
  }) async {
    await _labsCollection.doc(labId).set(<String, dynamic>{
      'userId': userId,
      'name': draft.name,
      'description': draft.description,
      'iconId': draft.iconId,
      'colorHex': draft.colorHex,
    }, SetOptions(merge: true));
  }

  Future<void> deleteLab({
    required String labId,
    required String userId,
  }) async {
    await _labsCollection.doc(labId).delete();
  }

  Stream<LabModel?> watchLabById(String labId) {
    return _labsCollection.doc(labId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return LabModel.fromDoc(snapshot);
    });
  }

  Future<LabDeletionCheck> canDeleteLab(String labId) async {
    final query = _experimentsCollection.where('labId', isEqualTo: labId);

    try {
      final aggregate = await query.count().get();
      final count = aggregate.count ?? 0;
      if (count > 0) {
        return const LabDeletionCheck(
          canDelete: false,
          reason:
              'This lab contains experiments. Move or end them before deleting the lab.',
        );
      }
    } catch (_) {
      final fallback = await query.limit(1).get();
      if (fallback.docs.isNotEmpty) {
        return const LabDeletionCheck(
          canDelete: false,
          reason:
              'This lab contains experiments. Move or end them before deleting the lab.',
        );
      }
    }

    return const LabDeletionCheck(canDelete: true);
  }

  Stream<LabStats> watchLabStats(String labId) {
    return _experimentsCollection
        .where('labId', isEqualTo: labId)
        .snapshots()
        .map((snapshot) {
          final total = snapshot.docs.length;
          final totalCompleted = snapshot.docs.where((doc) {
            return doc.data()['status'] == 'completed';
          }).length;

          return LabStats(
            totalExperiments: total,
            totalCompleted: totalCompleted,
          );
        });
  }
}
