import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ActiveExperimentsCount {
  const ActiveExperimentsCount(this._repository);

  final ExperimentsRepository _repository;

  Future<int> call(String userId) {
    return _repository.activeExperimentsCount(userId);
  }
}
