import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class EndExperiment {
  const EndExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String experimentId, DateTime now) {
    return _repository.endExperiment(experimentId, now);
  }

  Future<void> withOptionalReflection({
    required String experimentId,
    required DateTime now,
    String? finalReflection,
  }) {
    return _repository.endExperimentWithOptionalReflection(
      experimentId: experimentId,
      now: now,
      finalReflection: finalReflection,
    );
  }
}
