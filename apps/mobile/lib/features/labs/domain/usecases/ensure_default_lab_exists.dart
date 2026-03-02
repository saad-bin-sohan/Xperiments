import 'package:mobile/features/labs/domain/repositories/labs_repository.dart';

class EnsureDefaultLabExists {
  const EnsureDefaultLabExists(this._repository);

  final LabsRepository _repository;

  Future<void> call(String userId) {
    return _repository.ensureDefaultLabExists(userId);
  }
}
