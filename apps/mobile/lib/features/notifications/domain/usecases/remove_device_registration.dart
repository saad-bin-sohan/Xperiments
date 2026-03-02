import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class RemoveDeviceRegistration {
  const RemoveDeviceRegistration(this._repository);

  final NotificationsRepository _repository;

  Future<void> call({required String userId}) {
    return _repository.removeDeviceRegistration(userId: userId);
  }
}
