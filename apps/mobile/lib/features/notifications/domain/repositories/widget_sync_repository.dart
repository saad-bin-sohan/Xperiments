import 'package:mobile/features/notifications/domain/entities/widget_checklist_item.dart';

abstract class WidgetSyncRepository {
  Future<void> updateTodayWidget(List<WidgetChecklistItem> items);

  Stream<String> watchWidgetRouteOpens();

  Future<String?> getInitialWidgetRoute();
}
