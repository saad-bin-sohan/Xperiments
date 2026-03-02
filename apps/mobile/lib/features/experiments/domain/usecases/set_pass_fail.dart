import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class SetPassFail {
  const SetPassFail(this._repository);

  final ExperimentsRepository _repository;

  Future<void> call(String experimentId, PassFailResult? result) {
    return _repository.setPassFail(experimentId, result);
  }
}
