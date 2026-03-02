import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/features/labs/data/models/lab_model.dart';

class LabsRemoteDataSource {
  const LabsRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _labsCollection {
    return _firestore.collection(FirebaseCollections.labs);
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
}
