import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ResumeExperiment {
  const ResumeExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String experimentId, DateTime now) {
    return _repository.resumeExperiment(experimentId, now);
  }
}
