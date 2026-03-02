import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';

abstract class LabsRepository {
  Future<void> ensureDefaultLabExists(String userId);

  Stream<List<Lab>> watchUserLabs(String userId);

  Future<Lab> createLab({required String userId, required LabDraft draft});

  Future<void> updateLab({
    required String labId,
    required String userId,
    required LabDraft draft,
  });

  Future<void> deleteLab({required String labId, required String userId});

  Stream<Lab?> watchLabById(String labId);

  Future<LabDeletionCheck> canDeleteLab(String labId);

  Stream<LabStats> watchLabStats(String labId);
}
