import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class SaveLessonsLearned {
  const SaveLessonsLearned(this._repository);

  final HistoryRepository _repository;

  Future<void> call(String experimentId, String? lessons) {
    return _repository.saveLessonsLearned(experimentId, lessons);
  }
}
