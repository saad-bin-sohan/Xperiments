import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class UpdateExperiment {
  const UpdateExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call({
    required String experimentId,
    required ExperimentDraft draft,
  }) {
    return _repository.updateExperiment(
      experimentId: experimentId,
      draft: draft,
    );
  }
}
