import 'package:mobile/core/widget/home_widget_data_source.dart';
import 'package:mobile/features/notifications/domain/entities/widget_checklist_item.dart';
import 'package:mobile/features/notifications/domain/repositories/widget_sync_repository.dart';

class WidgetSyncRepositoryImpl implements WidgetSyncRepository {
  const WidgetSyncRepositoryImpl(this._dataSource);

  final HomeWidgetDataSource _dataSource;

  @override
  Future<String?> getInitialWidgetRoute() {
    return _dataSource.getInitialRoute();
  }

  @override
  Future<void> updateTodayWidget(List<WidgetChecklistItem> items) {
    return _dataSource.updateTodayChecklist(items);
  }

  @override
  Stream<String> watchWidgetRouteOpens() {
    return _dataSource.watchRouteOpens();
  }
}
