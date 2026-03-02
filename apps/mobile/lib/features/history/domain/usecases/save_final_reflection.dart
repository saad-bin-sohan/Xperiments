import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class SaveFinalReflection {
  const SaveFinalReflection(this._repository);

  final HistoryRepository _repository;

  Future<void> call(String experimentId, String? reflection) {
    return _repository.saveFinalReflection(experimentId, reflection);
  }
}
