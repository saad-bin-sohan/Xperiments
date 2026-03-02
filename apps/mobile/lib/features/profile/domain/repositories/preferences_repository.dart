import 'package:mobile/features/profile/domain/entities/user_preferences.dart';

abstract class PreferencesRepository {
  Stream<UserPreferences> watchPreferences(String userId);

  Future<UserPreferences> getPreferences(String userId);

  Future<void> updatePreferences({
    required String userId,
    required UserPreferencesPatch patch,
  });
}
