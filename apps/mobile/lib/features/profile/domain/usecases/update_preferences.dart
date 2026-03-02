import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/domain/repositories/preferences_repository.dart';

class UpdatePreferences {
  const UpdatePreferences(this._repository);

  final PreferencesRepository _repository;

  Future<void> call({
    required String userId,
    required UserPreferencesPatch patch,
  }) {
    return _repository.updatePreferences(userId: userId, patch: patch);
  }
}
