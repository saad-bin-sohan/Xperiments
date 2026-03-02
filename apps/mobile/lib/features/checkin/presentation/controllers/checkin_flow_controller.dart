import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';
import 'package:mobile/features/checkin/domain/entities/checkin_record.dart';
import 'package:mobile/features/checkin/presentation/providers/checkin_providers.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/notifications/domain/entities/widget_checklist_item.dart';
import 'package:mobile/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkin_flow_controller.g.dart';

@riverpod
class CheckinFlowController extends _$CheckinFlowController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<CheckinRecord?> save(CheckinDraft draft) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard<CheckinRecord>(() async {
      return ref.read(upsertCheckinUseCaseProvider).call(draft);
    });

    state = result.whenData((_) {});

    final saved = result.asData?.value;
    if (saved != null) {
      _invalidateExperimentState(draft.experimentId, draft.date);
      await _refreshWidget();
    }

    return saved;
  }

  Future<void> markRestDay(String experimentId, DateTime date) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(markRestDayUseCaseProvider).call(experimentId, date);
      _invalidateExperimentState(experimentId, date);
      await _refreshWidget();
    });
  }

  void _invalidateExperimentState(String experimentId, DateTime date) {
    ref.invalidate(
      checkinForDateProvider(
        CheckinLookupArgs(experimentId: experimentId, date: date),
      ),
    );
    ref.invalidate(todayDueItemsProvider);
    ref.invalidate(experimentAnalyticsProvider(experimentId));
    ref.invalidate(experimentByIdProvider(experimentId));
  }

  Future<void> _refreshWidget() async {
    final dueItems = await ref.read(todayDueItemsProvider.future);
    final widgetItems = dueItems.map((item) {
      return WidgetChecklistItem(
        experimentId: item.experiment.id,
        experimentName: item.experiment.name,
        labName: item.labName,
        isCheckedInToday: item.isCheckedInToday,
      );
    }).toList();

    await ref.read(widgetSyncRepositoryProvider).updateTodayWidget(widgetItems);
  }
}
