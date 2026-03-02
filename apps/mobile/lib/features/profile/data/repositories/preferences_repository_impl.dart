import 'package:mobile/features/profile/data/datasources/preferences_remote_data_source.dart';
import 'package:mobile/features/profile/data/models/user_preferences_model.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';
import 'package:mobile/features/profile/domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  const PreferencesRepositoryImpl(this._remoteDataSource);

  final PreferencesRemoteDataSource _remoteDataSource;

  @override
  Stream<UserPreferences> watchPreferences(String userId) {
    return _remoteDataSource.watchPreferences(userId).map(_toEntity);
  }

  @override
  Future<UserPreferences> getPreferences(String userId) async {
    final model = await _remoteDataSource.getPreferences(userId);
    return _toEntity(model);
  }

  @override
  Future<void> updatePreferences({
    required String userId,
    required UserPreferencesPatch patch,
  }) {
    return _remoteDataSource.updatePreferences(userId: userId, patch: patch);
  }

  UserPreferences _toEntity(UserPreferencesModel model) {
    return UserPreferences(
      theme: appThemePreferenceFromString(model.theme),
      notificationsEnabled: model.notificationsEnabled,
      nudgeDaysThreshold: model.nudgeDaysThreshold,
      friendAccountabilityEnabled: model.friendAccountabilityEnabled,
      friendEmails: model.friendEmails,
      journalEnabled: model.journalEnabled,
      interferenceLogEnabled: model.interferenceLogEnabled,
      passFailUiEnabled: model.passFailUiEnabled,
    );
  }
}
