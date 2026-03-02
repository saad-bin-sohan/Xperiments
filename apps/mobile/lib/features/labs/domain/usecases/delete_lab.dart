import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class DeleteLab {
  const DeleteLab(this._repository);

  final LabsRepository _repository;

  Future<void> call({required String labId, required String userId}) {
    return _repository.deleteLab(labId: labId, userId: userId);
  }
}
