import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/utils/date_utils.dart';
import 'package:mobile/features/checkin/data/models/checkin_model.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CheckinRemoteDataSource {
  const CheckinRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

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

    if (draft.removePhoto) {
      await _deleteLocalPhotoIfPresent(photoUrl);
      photoUrl = null;
    } else if (draft.photoFilePath != null &&
        draft.photoFilePath!.trim().isNotEmpty &&
        userId != null &&
        userId.isNotEmpty) {
      final previousPhotoUrl = photoUrl;
      photoUrl = await uploadCheckinPhoto(
        userId: userId,
        experimentId: draft.experimentId,
        date: dayStart,
        localPath: draft.photoFilePath!,
      );

      if (previousPhotoUrl != null && previousPhotoUrl != photoUrl) {
        await _deleteLocalPhotoIfPresent(previousPhotoUrl);
      }
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

    final sourceFile = compressed == null ? original : File(compressed.path);

    final appDocsDir = await getApplicationDocumentsDirectory();
    final targetDir = Directory(
      path.join(
        appDocsDir.path,
        'checkins',
        _safePathSegment(userId),
        _safePathSegment(experimentId),
      ),
    );
    await targetDir.create(recursive: true);

    final fileName =
        '${DateFormat('yyyy-MM-dd_HHmmss').format(date)}_'
        '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final destinationPath = path.join(targetDir.path, fileName);
    final persisted = await sourceFile.copy(destinationPath);

    if (compressed != null) {
      try {
        await File(compressed.path).delete();
      } catch (_) {}
    }

    return Uri.file(persisted.path).toString();
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

  Future<void> _deleteLocalPhotoIfPresent(String? photoUrl) async {
    if (photoUrl == null || photoUrl.trim().isEmpty) {
      return;
    }

    try {
      final parsed = Uri.tryParse(photoUrl);
      if (parsed != null && parsed.scheme == 'file') {
        final file = File(parsed.toFilePath());
        if (await file.exists()) {
          await file.delete();
        }
        return;
      }

      if (parsed == null || parsed.scheme.isEmpty) {
        final file = File(photoUrl);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (_) {}
  }

  String _safePathSegment(String input) {
    return input.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
  }
}
