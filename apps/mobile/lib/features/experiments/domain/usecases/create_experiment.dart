import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class CreateExperiment {
  const CreateExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<String> call(ExperimentDraft draft) {
    return _repository.createExperiment(draft);
  }
}
