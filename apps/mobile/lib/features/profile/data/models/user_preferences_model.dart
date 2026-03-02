import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/features/profile/domain/entities/user_preferences.dart';

part 'user_preferences_model.freezed.dart';

@freezed
abstract class UserPreferencesModel with _$UserPreferencesModel {
  const factory UserPreferencesModel({
    @Default('system') String theme,
    @Default(true) bool notificationsEnabled,
    @Default(kNudgeDaysThreshold) int nudgeDaysThreshold,
    @Default(false) bool friendAccountabilityEnabled,
    @Default(<String>[]) List<String> friendEmails,
    @Default(false) bool journalEnabled,
    @Default(false) bool interferenceLogEnabled,
    @Default(false) bool passFailUiEnabled,
    String? timezone,
  }) = _UserPreferencesModel;

  factory UserPreferencesModel.fromMap(Map<String, dynamic> map) {
    return UserPreferencesModel(
      theme: map['theme'] as String? ?? 'system',
      notificationsEnabled: map['notificationsEnabled'] as bool? ?? true,
      nudgeDaysThreshold:
          (map['nudgeDaysThreshold'] as num?)?.toInt() ?? kNudgeDaysThreshold,
      friendAccountabilityEnabled:
          map['friendAccountabilityEnabled'] as bool? ?? false,
      friendEmails: (map['friendEmails'] as List<dynamic>? ?? const <dynamic>[])
          .map((dynamic email) => email.toString())
          .toList(),
      journalEnabled: map['journalEnabled'] as bool? ?? false,
      interferenceLogEnabled: map['interferenceLogEnabled'] as bool? ?? false,
      passFailUiEnabled: map['passFailUiEnabled'] as bool? ?? false,
      timezone: map['timezone'] as String?,
    );
  }
}

extension UserPreferencesModelX on UserPreferencesModel {
  UserPreferences toEntity() {
    return UserPreferences(
      theme: appThemePreferenceFromString(theme),
      notificationsEnabled: notificationsEnabled,
      nudgeDaysThreshold: nudgeDaysThreshold,
      friendAccountabilityEnabled: friendAccountabilityEnabled,
      friendEmails: friendEmails,
      journalEnabled: journalEnabled,
      interferenceLogEnabled: interferenceLogEnabled,
      passFailUiEnabled: passFailUiEnabled,
      timezone: timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
      'nudgeDaysThreshold': nudgeDaysThreshold,
      'friendAccountabilityEnabled': friendAccountabilityEnabled,
      'friendEmails': friendEmails,
      'journalEnabled': journalEnabled,
      'interferenceLogEnabled': interferenceLogEnabled,
      'passFailUiEnabled': passFailUiEnabled,
      'timezone': timezone,
    };
  }
}

extension UserPreferencesEntityX on UserPreferences {
  UserPreferencesModel toModel() {
    return UserPreferencesModel(
      theme: appThemePreferenceToString(theme),
      notificationsEnabled: notificationsEnabled,
      nudgeDaysThreshold: nudgeDaysThreshold,
      friendAccountabilityEnabled: friendAccountabilityEnabled,
      friendEmails: friendEmails,
      journalEnabled: journalEnabled,
      interferenceLogEnabled: interferenceLogEnabled,
      passFailUiEnabled: passFailUiEnabled,
      timezone: timezone,
    );
  }
}
