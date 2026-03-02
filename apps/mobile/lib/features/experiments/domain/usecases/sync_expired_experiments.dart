import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class SyncExpiredExperiments {
  const SyncExpiredExperiments(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String userId, DateTime now) {
    return _repository.syncExpiredExperiments(userId, now);
  }
}
