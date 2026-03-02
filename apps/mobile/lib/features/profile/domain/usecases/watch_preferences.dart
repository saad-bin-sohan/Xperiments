import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/domain/repositories/preferences_repository.dart';

class WatchPreferences {
  const WatchPreferences(this._repository);

  final PreferencesRepository _repository;

  Stream<UserPreferences> call(String userId) {
    return _repository.watchPreferences(userId);
  }
}
