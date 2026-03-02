import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/core/constants/app_constants.dart';

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
    String? timezone,
  }) = _UserPreferencesModel;
}

extension UserPreferencesModelX on UserPreferencesModel {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
      'nudgeDaysThreshold': nudgeDaysThreshold,
      'friendAccountabilityEnabled': friendAccountabilityEnabled,
      'friendEmails': friendEmails,
      'journalEnabled': journalEnabled,
      'interferenceLogEnabled': interferenceLogEnabled,
      'timezone': timezone,
    };
  }
}
