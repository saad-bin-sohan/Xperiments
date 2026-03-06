import 'package:home_widget/home_widget.dart';
import 'package:mobile/core/diagnostics/diagnostic_logger.dart';
import 'package:mobile/features/notifications/domain/entities/widget_checklist_item.dart';

class HomeWidgetDataSource {
  const HomeWidgetDataSource();

  static const String providerName = 'TodayChecklistWidgetProvider';
  static const String androidProviderName =
      'com.xperiments.app.widget.TodayChecklistWidgetProvider';
  static const int maxRows = 5;

  Future<void> updateTodayChecklist(List<WidgetChecklistItem> items) async {
    try {
      final trimmed = items.take(maxRows).toList();

      await HomeWidget.saveWidgetData<int>(
        'today_widget_count',
        trimmed.length,
      );
      await HomeWidget.saveWidgetData<bool>(
        'today_widget_has_more',
        items.length > maxRows,
      );

      for (var i = 0; i < maxRows; i++) {
        if (i >= trimmed.length) {
          await HomeWidget.saveWidgetData<String>('today_widget_exp_id_$i', '');
          await HomeWidget.saveWidgetData<String>('today_widget_name_$i', '');
          await HomeWidget.saveWidgetData<String>('today_widget_lab_$i', '');
          await HomeWidget.saveWidgetData<bool>(
            'today_widget_checked_$i',
            false,
          );
          await HomeWidget.saveWidgetData<String>('today_widget_route_$i', '');
          continue;
        }

        final item = trimmed[i];
        final route = '/experiments/experiments/${item.experimentId}/checkin';

        await HomeWidget.saveWidgetData<String>(
          'today_widget_exp_id_$i',
          item.experimentId,
        );
        await HomeWidget.saveWidgetData<String>(
          'today_widget_name_$i',
          item.experimentName,
        );
        await HomeWidget.saveWidgetData<String>(
          'today_widget_lab_$i',
          item.labName,
        );
        await HomeWidget.saveWidgetData<bool>(
          'today_widget_checked_$i',
          item.isCheckedInToday,
        );
        await HomeWidget.saveWidgetData<String>('today_widget_route_$i', route);
      }

      await HomeWidget.updateWidget(qualifiedAndroidName: androidProviderName);
    } catch (error, stackTrace) {
      DiagnosticLogger.instance.logError(
        'HomeWidgetDataSource.updateTodayChecklist',
        error,
        stackTrace,
      );
    }
  }

  Stream<String> watchRouteOpens() {
    return HomeWidget.widgetClicked
        .map((uri) {
          if (uri == null) {
            return '';
          }
          return uri.queryParameters['route'] ?? '';
        })
        .where((route) => route.trim().isNotEmpty);
  }

  Future<String?> getInitialRoute() async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (uri == null) {
      return null;
    }

    final route = uri.queryParameters['route'];
    if (route == null || route.trim().isEmpty) {
      return null;
    }

    return route;
  }

  // TODO: iOS Widget — when iOS build begins (~1 week):
  // 1. Create a WidgetKit extension target in Xcode
  // 2. Implement the AppIntent for tap-to-checkin deep link
  // 3. Wire up home_widget's iOS UserDefaults data channel
  // No changes to this Dart file required.
}
