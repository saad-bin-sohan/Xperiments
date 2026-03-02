import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class EndExperiment {
  const EndExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String experimentId, DateTime now) {
    return _repository.endExperiment(experimentId, now);
  }
}
