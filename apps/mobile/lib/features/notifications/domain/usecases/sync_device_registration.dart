import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class SyncDeviceRegistration {
  const SyncDeviceRegistration(this._repository);

  final NotificationsRepository _repository;

  Future<void> call({
    required String userId,
    required bool notificationsEnabled,
  }) {
    return _repository.syncDeviceRegistration(
      userId: userId,
      notificationsEnabled: notificationsEnabled,
    );
  }
}
