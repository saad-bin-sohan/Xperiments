import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/features/checkin/data/models/checkin_model.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:path/path.dart' as path;

class CheckinRemoteDataSource {
  const CheckinRemoteDataSource(this._firestore, this._storage);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _experimentsCollection {
    return _firestore.collection(FirebaseCollections.experiments);
  }

  CollectionReference<Map<String, dynamic>> _checkinsCollection(
    String experimentId,
  ) {
    return _experimentsCollection
        .doc(experimentId)
        .collection(FirebaseCollections.checkins);
  }

  Future<CheckinModel?> getCheckinForDate(String experimentId, DateTime date) {
    return _findCheckinInDayWindow(experimentId, date);
  }

  Future<CheckinModel> upsertCheckin(CheckinDraft draft) async {
    final experimentDoc = await _experimentsCollection
        .doc(draft.experimentId)
        .get();

    if (!experimentDoc.exists) {
      throw StateError('Experiment not found for check-in.');
    }

    final experimentData = experimentDoc.data() ?? <String, dynamic>{};
    final userId = experimentData['userId'] as String?;

    final dayStart = AppDateUtils.startOfDay(draft.date);
    final dateKey = AppDateUtils.dateKey(dayStart);

    final existing = await _findCheckinInDayWindow(
      draft.experimentId,
      dayStart,
    );
    String? photoUrl = existing?.photoUrl;

    if (draft.photoFilePath != null &&
        draft.photoFilePath!.trim().isNotEmpty &&
        userId != null &&
        userId.isNotEmpty) {
      photoUrl = await uploadCheckinPhoto(
        userId: userId,
        experimentId: draft.experimentId,
        date: dayStart,
        localPath: draft.photoFilePath!,
      );
    }

    final payload = <String, dynamic>{
      'date': dayStart,
      'completed': !draft.isRestDay,
      'moodWords': _nullable(draft.moodWords),
      'subtaskCompletions': draft.subtaskCompletions,
      'rating': draft.rating,
      'photoURL': photoUrl,
      'journalEntry': _nullable(draft.journalEntry),
      'isBackfill': draft.isBackfill,
      'isRestDay': draft.isRestDay,
      'createdAt': FieldValue.serverTimestamp(),
    };

    final targetDoc = existing == null
        ? _checkinsCollection(draft.experimentId).doc(dateKey)
        : _checkinsCollection(draft.experimentId).doc(existing.id);

    await targetDoc.set(payload, SetOptions(merge: true));

    final saved = await targetDoc.get();
    return CheckinModel.fromDoc(saved, experimentId: draft.experimentId);
  }

  Future<void> markRestDay(String experimentId, DateTime date) async {
    final existing = await _findCheckinInDayWindow(experimentId, date);
    final dayStart = AppDateUtils.startOfDay(date);
    final targetDoc = existing == null
        ? _checkinsCollection(experimentId).doc(AppDateUtils.dateKey(dayStart))
        : _checkinsCollection(experimentId).doc(existing.id);

    await targetDoc.set(<String, dynamic>{
      'date': dayStart,
      'completed': false,
      'moodWords': null,
      'subtaskCompletions': const <String, bool>{},
      'rating': null,
      'photoURL': null,
      'journalEntry': null,
      'isBackfill': dayStart.isBefore(AppDateUtils.startOfDay(DateTime.now())),
      'isRestDay': true,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<String?> uploadCheckinPhoto({
    required String userId,
    required String experimentId,
    required DateTime date,
    required String localPath,
  }) async {
    final original = File(localPath);
    if (!await original.exists()) {
      return null;
    }

    final tempPath = path.join(
      Directory.systemTemp.path,
      'xperiments_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final compressed = await FlutterImageCompress.compressAndGetFile(
      localPath,
      tempPath,
      minWidth: 1600,
      minHeight: 1600,
      quality: 84,
      format: CompressFormat.jpeg,
    );

    final uploadFile = compressed == null ? original : File(compressed.path);

    final fileName = DateFormat('yyyy-MM-dd_HHmmss').format(date);
    final storageRef = _storage.ref().child(
      'checkins/$userId/$experimentId/$fileName.jpg',
    );

    await storageRef.putFile(
      uploadFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return storageRef.getDownloadURL();
  }

  Future<CheckinModel?> _findCheckinInDayWindow(
    String experimentId,
    DateTime day,
  ) async {
    final start = AppDateUtils.startOfDay(day);
    final nextDay = start.add(const Duration(days: 1));

    final snapshot = await _checkinsCollection(experimentId)
        .where('date', isGreaterThanOrEqualTo: start)
        .where('date', isLessThan: nextDay)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return CheckinModel.fromDoc(
      snapshot.docs.first,
      experimentId: experimentId,
    );
  }

  String? _nullable(String? input) {
    final trimmed = input?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
