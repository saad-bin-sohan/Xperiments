import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'experiment_action_controller.g.dart';

@riverpod
class ExperimentActionController extends _$ExperimentActionController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> pause(String experimentId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(pauseExperimentUseCaseProvider)
          .call(experimentId, DateTime.now());
      ref.invalidate(experimentAnalyticsProvider(experimentId));
    });
  }

  Future<void> resume(String experimentId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(resumeExperimentUseCaseProvider)
          .call(experimentId, DateTime.now());
      ref.invalidate(experimentAnalyticsProvider(experimentId));
    });
  }

  Future<void> end(String experimentId, {String? finalReflection}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(endExperimentUseCaseProvider)
          .withOptionalReflection(
            experimentId: experimentId,
            now: DateTime.now(),
            finalReflection: finalReflection,
          );
      ref.invalidate(experimentAnalyticsProvider(experimentId));
      ref.invalidate(experimentByIdProvider(experimentId));
    });
  }

  Future<void> setPassFail(String experimentId, PassFailResult? result) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(setPassFailUseCaseProvider).call(experimentId, result);
      ref.invalidate(experimentByIdProvider(experimentId));
    });
  }

  Future<void> replaceSubtasks(
    String experimentId,
    List<ExperimentSubtask> subtasks,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(replaceSubtasksUseCaseProvider)
          .call(experimentId, subtasks);
    });
  }

  Future<void> resolveExpired({
    required String experimentId,
    required ExpiredResolution resolution,
    String? finalReflection,
    String? skipReason,
    DateTime? newEndDate,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(resolveExpiredExperimentUseCaseProvider)
          .call(
            experimentId: experimentId,
            resolution: resolution,
            finalReflection: finalReflection,
            skipReason: skipReason,
            newEndDate: newEndDate,
          );
      ref.invalidate(experimentByIdProvider(experimentId));
      ref.invalidate(experimentAnalyticsProvider(experimentId));
    });
  }
}
