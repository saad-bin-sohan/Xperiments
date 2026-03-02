import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class WatchHistoryGroupedByLab {
  const WatchHistoryGroupedByLab(this._repository);

  final HistoryRepository _repository;

  Stream<List<HistoryExperimentGroup>> call(String userId) {
    return _repository.watchHistoryGroupedByLab(userId);
  }
}
