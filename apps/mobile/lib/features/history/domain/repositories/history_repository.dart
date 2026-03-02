import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/domain/entities/summary_text_result.dart';

abstract class HistoryRepository {
  Stream<List<HistoryExperimentGroup>> watchHistoryGroupedByLab(String userId);

  Future<void> saveFinalReflection(String experimentId, String? reflection);

  Future<void> saveLessonsLearned(String experimentId, String? lessons);

  Future<List<HistorySearchResult>> searchHistoryContent(
    String userId,
    String query,
  );

  Future<SummaryTextResult> buildMonthlySummary(String userId, DateTime now);

  Future<SummaryTextResult> buildYearlySummary(String userId, DateTime now);
}
