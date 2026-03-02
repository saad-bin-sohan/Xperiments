import 'package:mobile/features/experiments/domain/entities/experiment_draft.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'experiment_form_controller.g.dart';

@riverpod
class ExperimentFormController extends _$ExperimentFormController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<String?> createExperiment(ExperimentDraft draft) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard<String?>(() async {
      return ref.read(createExperimentUseCaseProvider).call(draft);
    });
    state = result.whenData((_) {});
    return result.asData?.value;
  }

  Future<void> updateExperiment({
    required String experimentId,
    required ExperimentDraft draft,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(updateExperimentUseCaseProvider)
          .call(experimentId: experimentId, draft: draft);
    });
  }
}
