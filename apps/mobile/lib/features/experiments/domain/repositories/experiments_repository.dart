import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';

abstract class ExperimentsRepository {
  Future<String> createExperiment(ExperimentDraft draft);

  Future<void> updateExperiment({
    required String experimentId,
    required ExperimentDraft draft,
  });

  Stream<List<Experiment>> watchLabExperiments(String labId);

  Stream<Experiment?> watchExperimentById(String experimentId);

  Future<void> pauseExperiment(String experimentId, DateTime now);

  Future<void> resumeExperiment(String experimentId, DateTime now);

  Future<void> endExperiment(String experimentId, DateTime now);

  Future<void> endExperimentWithOptionalReflection({
    required String experimentId,
    required DateTime now,
    String? finalReflection,
  });

  Future<void> setPassFail(String experimentId, PassFailResult? result);

  Future<void> replaceSubtasks(
    String experimentId,
    List<ExperimentSubtask> subtasks,
  );

  Stream<List<TodayDueItem>> watchTodayDueItems(String userId, DateTime now);

  Future<ExperimentAnalytics> computeAnalytics(
    String experimentId,
    DateTime now,
  );

  Future<void> syncExpiredExperiments(String userId, DateTime now);

  Future<int> activeExperimentsCount(String userId);
}
