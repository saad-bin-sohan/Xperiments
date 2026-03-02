import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ReplaceSubtasks {
  const ReplaceSubtasks(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String experimentId, List<ExperimentSubtask> subtasks) {
    return _repository.replaceSubtasks(experimentId, subtasks);
  }
}
