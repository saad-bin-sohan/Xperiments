import 'package:mobile/features/experiments/data/datasources/experiments_remote_data_source.dart';
import 'package:mobile/features/experiments/data/models/experiment_model.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';

class ExperimentsRepositoryImpl implements ExperimentsRepository {
  const ExperimentsRepositoryImpl(this._remoteDataSource);

  final ExperimentsRemoteDataSource _remoteDataSource;

  @override
  Future<String> createExperiment(ExperimentDraft draft) {
    return _remoteDataSource.createExperiment(draft);
  }

  @override
  Future<void> updateExperiment({
    required String experimentId,
    required ExperimentDraft draft,
  }) {
    return _remoteDataSource.updateExperiment(
      experimentId: experimentId,
      draft: draft,
    );
  }

  @override
  Stream<List<Experiment>> watchLabExperiments({
    required String labId,
    required String userId,
  }) {
    return _remoteDataSource
        .watchLabExperiments(labId: labId, userId: userId)
        .map((models) {
          return models.map(_toEntity).toList();
        });
  }

  @override
  Stream<Experiment?> watchExperimentById(String experimentId) {
    return _remoteDataSource.watchExperimentById(experimentId).map((model) {
      if (model == null) {
        return null;
      }
      return _toEntity(model);
    });
  }

  @override
  Future<void> pauseExperiment(String experimentId, DateTime now) {
    return _remoteDataSource.pauseExperiment(experimentId, now);
  }

  @override
  Future<void> resumeExperiment(String experimentId, DateTime now) {
    return _remoteDataSource.resumeExperiment(experimentId, now);
  }

  @override
  Future<void> endExperiment(String experimentId, DateTime now) {
    return _remoteDataSource.endExperiment(experimentId, now);
  }

  @override
  Future<void> endExperimentWithOptionalReflection({
    required String experimentId,
    required DateTime now,
    String? finalReflection,
  }) {
    return _remoteDataSource.endExperimentWithOptionalReflection(
      experimentId: experimentId,
      now: now,
      finalReflection: finalReflection,
    );
  }

  @override
  Future<void> setPassFail(String experimentId, PassFailResult? result) {
    return _remoteDataSource.setPassFail(experimentId, result);
  }

  @override
  Future<void> replaceSubtasks(
    String experimentId,
    List<ExperimentSubtask> subtasks,
  ) {
    return _remoteDataSource.replaceSubtasks(experimentId, subtasks);
  }

  @override
  Stream<List<TodayDueItem>> watchTodayDueItems(String userId, DateTime now) {
    return _remoteDataSource.watchTodayDueItems(userId, now);
  }

  @override
  Future<ExperimentAnalytics> computeAnalytics(
    String experimentId,
    DateTime now,
  ) {
    return _remoteDataSource.computeAnalytics(experimentId, now);
  }

  @override
  Future<void> syncExpiredExperiments(String userId, DateTime now) {
    return _remoteDataSource.syncExpiredExperiments(userId, now);
  }

  @override
  Future<int> activeExperimentsCount(String userId) {
    return _remoteDataSource.activeExperimentsCount(userId);
  }

  Experiment _toEntity(ExperimentModel model) {
    return model.toEntity();
  }
}
