import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/history/data/datasources/history_remote_data_source.dart';
import 'package:mobile/features/history/data/repositories/history_repository_impl.dart';
import 'package:mobile/features/history/domain/entities/history_experiment_group.dart';
import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/domain/entities/summary_text_result.dart';
import 'package:mobile/features/history/domain/repositories/history_repository.dart';
import 'package:mobile/features/history/domain/usecases/build_monthly_summary.dart';
import 'package:mobile/features/history/domain/usecases/build_yearly_summary.dart';
import 'package:mobile/features/history/domain/usecases/save_debrief.dart';
import 'package:mobile/features/history/domain/usecases/save_final_reflection.dart';
import 'package:mobile/features/history/domain/usecases/save_lessons_learned.dart';
import 'package:mobile/features/history/domain/usecases/search_history_content.dart';
import 'package:mobile/features/history/domain/usecases/watch_history_grouped_by_lab.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

@Riverpod(keepAlive: true)
HistoryRemoteDataSource historyRemoteDataSource(Ref ref) {
  return HistoryRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.watch(historyRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
WatchHistoryGroupedByLab watchHistoryGroupedByLabUseCase(Ref ref) {
  return WatchHistoryGroupedByLab(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
SaveFinalReflection saveFinalReflectionUseCase(Ref ref) {
  return SaveFinalReflection(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
SaveLessonsLearned saveLessonsLearnedUseCase(Ref ref) {
  return SaveLessonsLearned(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
SaveDebrief saveDebriefUseCase(Ref ref) {
  return SaveDebrief(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
SearchHistoryContent searchHistoryContentUseCase(Ref ref) {
  return SearchHistoryContent(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
BuildMonthlySummary buildMonthlySummaryUseCase(Ref ref) {
  return BuildMonthlySummary(ref.watch(historyRepositoryProvider));
}

@Riverpod(keepAlive: true)
BuildYearlySummary buildYearlySummaryUseCase(Ref ref) {
  return BuildYearlySummary(ref.watch(historyRepositoryProvider));
}

@riverpod
Stream<List<HistoryExperimentGroup>> historyGroups(Ref ref) {
  final session = ref.watch(authSessionProvider).asData?.value;
  final user = session?.user;

  if (user == null) {
    return Stream<List<HistoryExperimentGroup>>.value(
      const <HistoryExperimentGroup>[],
    );
  }

  return ref.watch(watchHistoryGroupedByLabUseCaseProvider).call(user.id);
}

@riverpod
Future<List<HistorySearchResult>> historySearch(Ref ref, String query) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;
  if (user == null || query.trim().isEmpty) {
    return const <HistorySearchResult>[];
  }

  return ref.watch(searchHistoryContentUseCaseProvider).call(user.id, query);
}

@riverpod
Future<SummaryTextResult> monthlySummary(Ref ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;

  if (user == null) {
    return const SummaryTextResult(periodLabel: '', text: 'Sign in required.');
  }

  return ref
      .watch(buildMonthlySummaryUseCaseProvider)
      .call(user.id, DateTime.now());
}

@riverpod
Future<SummaryTextResult> yearlySummary(Ref ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;

  if (user == null) {
    return const SummaryTextResult(periodLabel: '', text: 'Sign in required.');
  }

  return ref
      .watch(buildYearlySummaryUseCaseProvider)
      .call(user.id, DateTime.now());
}
