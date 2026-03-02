import 'package:mobile/features/history/domain/entities/summary_text_result.dart';
import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class BuildYearlySummary {
  const BuildYearlySummary(this._repository);

  final HistoryRepository _repository;

  Future<SummaryTextResult> call(String userId, DateTime now) {
    return _repository.buildYearlySummary(userId, now);
  }
}
