import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class WatchLabExperiments {
  const WatchLabExperiments(this._repository);

  final ExperimentsRepository _repository;

  Stream<List<Experiment>> call(String labId) {
    return _repository.watchLabExperiments(labId);
  }
}
