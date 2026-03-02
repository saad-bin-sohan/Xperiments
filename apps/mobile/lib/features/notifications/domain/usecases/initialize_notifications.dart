import 'package:mobile/features/notifications/domain/repositories/notifications_repository.dart';

class InitializeNotifications {
  const InitializeNotifications(this._repository);

  final NotificationsRepository _repository;

  Future<void> call() {
    return _repository.initialize();
  }
}
