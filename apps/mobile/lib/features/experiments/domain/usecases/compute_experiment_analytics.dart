import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ComputeExperimentAnalytics {
  const ComputeExperimentAnalytics(this._repository);

  final ExperimentsRepository _repository;

  Future<ExperimentAnalytics> call(String experimentId, DateTime now) {
    return _repository.computeAnalytics(experimentId, now);
  }
}
