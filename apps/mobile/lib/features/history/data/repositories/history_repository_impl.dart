import 'package:mobile/features/history/data/datasources/history_remote_data_source.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/domain/entities/summary_text_result.dart';
import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._remoteDataSource);

  final HistoryRemoteDataSource _remoteDataSource;

  @override
  Stream<List<HistoryExperimentGroup>> watchHistoryGroupedByLab(String userId) {
    return _remoteDataSource.watchHistoryGroupedByLab(userId);
  }

  @override
  Future<void> saveFinalReflection(String experimentId, String? reflection) {
    return _remoteDataSource.saveFinalReflection(experimentId, reflection);
  }

  @override
  Future<void> saveLessonsLearned(String experimentId, String? lessons) {
    return _remoteDataSource.saveLessonsLearned(experimentId, lessons);
  }

  @override
  Future<List<HistorySearchResult>> searchHistoryContent(
    String userId,
    String query,
  ) {
    return _remoteDataSource.searchHistoryContent(userId, query);
  }

  @override
  Future<SummaryTextResult> buildMonthlySummary(String userId, DateTime now) {
    return _remoteDataSource.buildMonthlySummary(userId, now);
  }

  @override
  Future<SummaryTextResult> buildYearlySummary(String userId, DateTime now) {
    return _remoteDataSource.buildYearlySummary(userId, now);
  }
}
