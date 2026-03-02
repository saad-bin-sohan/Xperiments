import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class WatchExperimentById {
  const WatchExperimentById(this._repository);

  final ExperimentsRepository _repository;

  Stream<Experiment?> call(String experimentId) {
    return _repository.watchExperimentById(experimentId);
  }
}
