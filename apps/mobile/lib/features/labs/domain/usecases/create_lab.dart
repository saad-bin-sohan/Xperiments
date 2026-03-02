import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class CreateLab {
  const CreateLab(this._repository);

  final LabsRepository _repository;

  Future<Lab> call({required String userId, required LabDraft draft}) {
    return _repository.createLab(userId: userId, draft: draft);
  }
}
