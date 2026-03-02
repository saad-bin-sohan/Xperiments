import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/notifications/notification_route_path.dart';
import 'package:mobile/core/routing/app_router.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/theme/theme_mode_controller.dart';
import 'package:mobile/features/experiments/domain/entities/today_due_item.dart';
import 'package:mobile/features/experiments/presentation/providers/experiments_providers.dart';
import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:mobile/features/notifications/domain/entities/widget_checklist_item.dart';
import 'package:mobile/features/notifications/presentation/providers/notifications_providers.dart';

class XperimentsApp extends ConsumerStatefulWidget {
  const XperimentsApp({super.key});

  @override
  ConsumerState<XperimentsApp> createState() => _XperimentsAppState();
}

class _XperimentsAppState extends ConsumerState<XperimentsApp>
    with WidgetsBindingObserver {
  bool _initialNotificationHandled = false;
  bool _initialWidgetHandled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_syncWidgetFromCurrentTodayDue());
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);

    ref.watch(notificationsBootstrapProvider);

    ref.listen<AsyncValue<AppNotificationRoute>>(
      notificationOpenRoutesProvider,
      (_, next) {
        next.whenData((route) {
          _navigate(router, NotificationRoutePath.toPath(route));
        });
      },
    );

    ref.listen<AsyncValue<AppNotificationRoute>>(
      foregroundNotificationRoutesProvider,
      (_, next) {
        next.whenData((route) {
          final context = rootNavigatorKey.currentContext;
          if (context == null) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Notification received.'),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () {
                  _navigate(router, NotificationRoutePath.toPath(route));
                },
              ),
            ),
          );
        });
      },
    );

    ref.listen<AsyncValue<String>>(widgetOpenRoutesProvider, (_, next) {
      next.whenData((route) {
        _navigate(router, route);
      });
    });

    ref.listen<AsyncValue<List<TodayDueItem>>>(todayDueItemsProvider, (
      _,
      next,
    ) {
      next.whenData((items) {
        unawaited(_syncWidgetFromTodayDue(items));
      });
    });

    final initialNotificationAsync = ref.watch(
      initialNotificationRouteProvider,
    );
    initialNotificationAsync.whenData((route) {
      if (_initialNotificationHandled || route == null) {
        return;
      }
      _initialNotificationHandled = true;
      _navigate(router, NotificationRoutePath.toPath(route));
    });

    final initialWidgetRouteAsync = ref.watch(initialWidgetRouteProvider);
    initialWidgetRouteAsync.whenData((route) {
      if (_initialWidgetHandled || route == null || route.trim().isEmpty) {
        return;
      }
      _initialWidgetHandled = true;
      _navigate(router, route);
    });

    return MaterialApp.router(
      title: 'Xperiments',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode.asData?.value ?? ThemeMode.system,
    );
  }

  void _navigate(GoRouter router, String path) {
    if (path.trim().isEmpty) {
      return;
    }

    router.push(path);
  }

  Future<void> _syncWidgetFromCurrentTodayDue() async {
    final todayDue = await ref.read(todayDueItemsProvider.future);
    await _syncWidgetFromTodayDue(todayDue);
  }

  Future<void> _syncWidgetFromTodayDue(List<TodayDueItem> dueItems) async {
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
