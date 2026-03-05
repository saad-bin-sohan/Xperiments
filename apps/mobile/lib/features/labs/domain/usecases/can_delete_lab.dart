import 'package:mobile/features/labs/domain/entities/lab_deletion_check.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class CanDeleteLab {
  const CanDeleteLab(this._repository);

  final LabsRepository _repository;

  Future<LabDeletionCheck> call({
    required String labId,
    required String userId,
  }) {
    return _repository.canDeleteLab(labId: labId, userId: userId);
  }
}
