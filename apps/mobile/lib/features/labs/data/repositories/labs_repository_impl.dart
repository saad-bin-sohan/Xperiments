import 'package:mobile/features/labs/data/datasources/labs_remote_data_source.dart';
import 'package:mobile/features/labs/data/models/lab_model.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/domain/entities/lab_stats.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class LabsRepositoryImpl implements LabsRepository {
  const LabsRepositoryImpl(this._remoteDataSource);

  final LabsRemoteDataSource _remoteDataSource;

  @override
  Future<void> ensureDefaultLabExists(String userId) {
    return _remoteDataSource.ensureDefaultLabExists(userId);
  }

  @override
  Stream<List<Lab>> watchUserLabs(String userId) {
    return _remoteDataSource.watchUserLabs(userId).map((models) {
      return models.map(_toEntity).toList();
    });
  }

  @override
  Future<Lab> createLab({
    required String userId,
    required LabDraft draft,
  }) async {
    final model = await _remoteDataSource.createLab(
      userId: userId,
      draft: draft,
    );
    return _toEntity(model);
  }

  @override
  Future<void> updateLab({
    required String labId,
    required String userId,
    required LabDraft draft,
  }) {
    return _remoteDataSource.updateLab(
      labId: labId,
      userId: userId,
      draft: draft,
    );
  }

  @override
  Future<void> deleteLab({required String labId, required String userId}) {
    return _remoteDataSource.deleteLab(labId: labId, userId: userId);
  }

  @override
  Stream<Lab?> watchLabById(String labId) {
    return _remoteDataSource.watchLabById(labId).map((model) {
      if (model == null) {
        return null;
      }
      return _toEntity(model);
    });
  }

  @override
  Future<LabDeletionCheck> canDeleteLab({
    required String labId,
    required String userId,
  }) {
    return _remoteDataSource.canDeleteLab(labId: labId, userId: userId);
  }

  @override
  Stream<LabStats> watchLabStats({
    required String labId,
    required String userId,
  }) {
    return _remoteDataSource.watchLabStats(labId: labId, userId: userId);
  }

  Lab _toEntity(LabModel model) {
    return Lab(
      id: model.id,
      userId: model.userId,
      name: model.name,
      description: model.description,
      iconId: model.iconId,
      colorHex: model.colorHex,
      createdAt: model.createdAt,
    );
  }
}
