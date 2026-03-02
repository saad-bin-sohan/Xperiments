import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/core/widget/home_widget_data_source.dart';
import 'package:mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:mobile/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mobile/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:mobile/features/notifications/data/repositories/widget_sync_repository_impl.dart';
import 'package:mobile/features/notifications/domain/entities/app_notification_route.dart';
import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mobile/features/notifications/domain/repositories/widget_sync_repository.dart';
import 'package:mobile/features/notifications/domain/usecases/handle_initial_notification_route.dart';
import 'package:mobile/features/notifications/domain/usecases/initialize_notifications.dart';
import 'package:mobile/features/notifications/domain/usecases/remove_device_registration.dart';
import 'package:mobile/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:mobile/features/notifications/domain/usecases/sync_device_registration.dart';
import 'package:mobile/features/notifications/domain/usecases/watch_foreground_notifications.dart';
import 'package:mobile/features/notifications/domain/usecases/watch_notification_opens.dart';
import 'package:mobile/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRemoteDataSource notificationsRemoteDataSource(Ref ref) {
  return NotificationsRemoteDataSource(
    firestore: ref.watch(firestoreProvider),
    messaging: ref.watch(firebaseMessagingProvider),
  );
}

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(Ref ref) {
  return NotificationsRepositoryImpl(
    ref.watch(notificationsRemoteDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
WidgetSyncRepository widgetSyncRepository(Ref ref) {
  return const WidgetSyncRepositoryImpl(HomeWidgetDataSource());
}

@Riverpod(keepAlive: true)
InitializeNotifications initializeNotificationsUseCase(Ref ref) {
  return InitializeNotifications(ref.watch(notificationsRepositoryProvider));
}

@Riverpod(keepAlive: true)
RequestNotificationPermission requestNotificationPermissionUseCase(Ref ref) {
  return RequestNotificationPermission(
    ref.watch(notificationsRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
SyncDeviceRegistration syncDeviceRegistrationUseCase(Ref ref) {
  return SyncDeviceRegistration(ref.watch(notificationsRepositoryProvider));
}

@Riverpod(keepAlive: true)
RemoveDeviceRegistration removeDeviceRegistrationUseCase(Ref ref) {
  return RemoveDeviceRegistration(ref.watch(notificationsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchNotificationOpens watchNotificationOpensUseCase(Ref ref) {
  return WatchNotificationOpens(ref.watch(notificationsRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchForegroundNotifications watchForegroundNotificationsUseCase(Ref ref) {
  return WatchForegroundNotifications(
    ref.watch(notificationsRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
HandleInitialNotificationRoute handleInitialNotificationRouteUseCase(Ref ref) {
  return HandleInitialNotificationRoute(
    ref.watch(notificationsRepositoryProvider),
  );
}

@riverpod
Future<void> notificationsBootstrap(Ref ref) async {
  await ref.watch(initializeNotificationsUseCaseProvider).call();

  final session = await ref.watch(authSessionProvider.future);
  final user = session.user;
  if (user == null) {
    return;
  }

  final preferences = await ref.watch(currentUserPreferencesProvider.future);

  if (preferences.notificationsEnabled) {
    await ref.watch(requestNotificationPermissionUseCaseProvider).call();
  }

  await ref
      .watch(syncDeviceRegistrationUseCaseProvider)
      .call(
        userId: user.id,
        notificationsEnabled: preferences.notificationsEnabled,
      );
}

@riverpod
Stream<AppNotificationRoute> notificationOpenRoutes(Ref ref) {
  return ref.watch(watchNotificationOpensUseCaseProvider).call();
}

@riverpod
Stream<AppNotificationRoute> foregroundNotificationRoutes(Ref ref) {
  return ref.watch(watchForegroundNotificationsUseCaseProvider).call();
}

@riverpod
Future<AppNotificationRoute?> initialNotificationRoute(Ref ref) {
  return ref.watch(handleInitialNotificationRouteUseCaseProvider).call();
}

@riverpod
Stream<String> widgetOpenRoutes(Ref ref) {
  return ref.watch(widgetSyncRepositoryProvider).watchWidgetRouteOpens();
}

@riverpod
Future<String?> initialWidgetRoute(Ref ref) {
  return ref.watch(widgetSyncRepositoryProvider).getInitialWidgetRoute();
}
