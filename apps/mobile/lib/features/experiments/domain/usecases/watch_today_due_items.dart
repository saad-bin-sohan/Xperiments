import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class WatchTodayDueItems {
  const WatchTodayDueItems(this._repository);

  final ExperimentsRepository _repository;

  Stream<List<TodayDueItem>> call(String userId, DateTime now) {
    return _repository.watchTodayDueItems(userId, now);
  }
}
