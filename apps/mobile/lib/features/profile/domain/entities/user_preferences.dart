import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';

enum AppThemePreference { system, light, dark }

AppThemePreference appThemePreferenceFromString(String value) {
  switch (value) {
    case 'light':
      return AppThemePreference.light;
    case 'dark':
      return AppThemePreference.dark;
    case 'system':
    default:
      return AppThemePreference.system;
  }
}

String appThemePreferenceToString(AppThemePreference value) {
  switch (value) {
    case AppThemePreference.system:
      return 'system';
    case AppThemePreference.light:
      return 'light';
    case AppThemePreference.dark:
      return 'dark';
  }
}

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default(AppThemePreference.system) AppThemePreference theme,
    @Default(true) bool notificationsEnabled,
    @Default(7) int nudgeDaysThreshold,
    @Default(false) bool friendAccountabilityEnabled,
    @Default(<String>[]) List<String> friendEmails,
    @Default(false) bool journalEnabled,
    @Default(false) bool interferenceLogEnabled,
    @Default(false) bool passFailUiEnabled,
  }) = _UserPreferences;
}

@freezed
abstract class UserPreferencesPatch with _$UserPreferencesPatch {
  const factory UserPreferencesPatch({
    AppThemePreference? theme,
    bool? notificationsEnabled,
    int? nudgeDaysThreshold,
    bool? friendAccountabilityEnabled,
    List<String>? friendEmails,
    bool? journalEnabled,
    bool? interferenceLogEnabled,
    bool? passFailUiEnabled,
  }) = _UserPreferencesPatch;
}
