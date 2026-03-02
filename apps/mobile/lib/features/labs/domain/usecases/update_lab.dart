import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class UpdateLab {
  const UpdateLab(this._repository);

  final LabsRepository _repository;

  Future<void> call({
    required String labId,
    required String userId,
    required LabDraft draft,
  }) {
    return _repository.updateLab(labId: labId, userId: userId, draft: draft);
  }
}
