import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/experiments/data/datasources/experiments_remote_data_source.dart';
import 'package:mobile/features/experiments/data/repositories/experiments_repository_impl.dart';
import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/domain/entities/experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';
import 'package:mobile/features/experiments/domain/repositories/experiments_repository.dart';
import 'package:mobile/features/experiments/domain/usecases/active_experiments_count.dart';
import 'package:mobile/features/experiments/domain/usecases/compute_experiment_analytics.dart';
import 'package:mobile/features/experiments/domain/usecases/create_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/end_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/pause_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/replace_subtasks.dart';
import 'package:mobile/features/experiments/domain/usecases/resolve_expired_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/resume_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/set_pass_fail.dart';
import 'package:mobile/features/experiments/domain/usecases/sync_expired_experiments.dart';
import 'package:mobile/features/experiments/domain/usecases/update_experiment.dart';
import 'package:mobile/features/experiments/domain/usecases/watch_experiment_by_id.dart';
import 'package:mobile/features/experiments/domain/usecases/watch_lab_experiments.dart';
import 'package:mobile/features/experiments/domain/usecases/watch_today_due_items.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'experiments_providers.g.dart';

@Riverpod(keepAlive: true)
ExperimentsRemoteDataSource experimentsRemoteDataSource(Ref ref) {
  return ExperimentsRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
ExperimentsRepository experimentsRepository(Ref ref) {
  return ExperimentsRepositoryImpl(
    ref.watch(experimentsRemoteDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
CreateExperiment createExperimentUseCase(Ref ref) {
  return CreateExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateExperiment updateExperimentUseCase(Ref ref) {
  return UpdateExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchLabExperiments watchLabExperimentsUseCase(Ref ref) {
  return WatchLabExperiments(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchExperimentById watchExperimentByIdUseCase(Ref ref) {
  return WatchExperimentById(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
PauseExperiment pauseExperimentUseCase(Ref ref) {
  return PauseExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
ResumeExperiment resumeExperimentUseCase(Ref ref) {
  return ResumeExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
EndExperiment endExperimentUseCase(Ref ref) {
  return EndExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
SetPassFail setPassFailUseCase(Ref ref) {
  return SetPassFail(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
ReplaceSubtasks replaceSubtasksUseCase(Ref ref) {
  return ReplaceSubtasks(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchTodayDueItems watchTodayDueItemsUseCase(Ref ref) {
  return WatchTodayDueItems(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
ComputeExperimentAnalytics computeExperimentAnalyticsUseCase(Ref ref) {
  return ComputeExperimentAnalytics(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
SyncExpiredExperiments syncExpiredExperimentsUseCase(Ref ref) {
  return SyncExpiredExperiments(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
ResolveExpiredExperiment resolveExpiredExperimentUseCase(Ref ref) {
  return ResolveExpiredExperiment(ref.watch(experimentsRepositoryProvider));
}

@Riverpod(keepAlive: true)
ActiveExperimentsCount activeExperimentsCountUseCase(Ref ref) {
  return ActiveExperimentsCount(ref.watch(experimentsRepositoryProvider));
}

@riverpod
Stream<List<Experiment>> labExperiments(Ref ref, String labId) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<List<Experiment>>.value(const <Experiment>[]);
  }

  return ref
      .watch(watchLabExperimentsUseCaseProvider)
      .call(labId: labId, userId: user.id);
}

@riverpod
Stream<Experiment?> experimentById(Ref ref, String experimentId) {
  return ref.watch(watchExperimentByIdUseCaseProvider).call(experimentId);
}

@riverpod
Stream<List<TodayDueItem>> todayDueItems(Ref ref) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<List<TodayDueItem>>.value(const <TodayDueItem>[]);
  }

  return ref
      .watch(watchTodayDueItemsUseCaseProvider)
      .call(user.id, DateTime.now());
}

@riverpod
Future<ExperimentAnalytics> experimentAnalytics(Ref ref, String experimentId) {
  return ref
      .watch(computeExperimentAnalyticsUseCaseProvider)
      .call(experimentId, DateTime.now());
}

@riverpod
Future<void> syncCurrentUserExpiredExperiments(Ref ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;

  if (user == null) {
    return;
  }

  await ref
      .watch(syncExpiredExperimentsUseCaseProvider)
      .call(user.id, DateTime.now());
}

@riverpod
Future<int> activeExperimentsCount(Ref ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;

  if (user == null) {
    return 0;
  }

  return ref.watch(activeExperimentsCountUseCaseProvider).call(user.id);
}

@riverpod
bool passFailFeatureVisible(Ref ref) {
  final remoteEnabled = ref.watch(passFailEnabledProvider);
  final userPref =
      ref
          .watch(currentUserPreferencesProvider)
          .asData
          ?.value
          .passFailUiEnabled ??
      false;
  return remoteEnabled && userPref;
}
