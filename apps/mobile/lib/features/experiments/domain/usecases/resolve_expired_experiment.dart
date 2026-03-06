import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ResolveExpiredExperiment {
  const ResolveExpiredExperiment(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call({
    required String experimentId,
    required ExpiredResolution resolution,
    String? finalReflection,
    String? skipReason,
    DateTime? newEndDate,
  }) {
    return _repository.resolveExpiredExperiment(
      experimentId: experimentId,
      resolution: resolution,
      finalReflection: finalReflection,
      skipReason: skipReason,
      newEndDate: newEndDate,
    );
  }
}
