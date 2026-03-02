// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserPreferencesModel {

 String get theme; bool get notificationsEnabled; int get nudgeDaysThreshold; bool get friendAccountabilityEnabled; List<String> get friendEmails; bool get journalEnabled; bool get interferenceLogEnabled; bool get passFailUiEnabled; String? get timezone;
/// Create a copy of UserPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesModelCopyWith<UserPreferencesModel> get copyWith => _$UserPreferencesModelCopyWithImpl<UserPreferencesModel>(this as UserPreferencesModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferencesModel&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other.friendEmails, friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferencesModel(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesModelCopyWith<$Res>  {
  factory $UserPreferencesModelCopyWith(UserPreferencesModel value, $Res Function(UserPreferencesModel) _then) = _$UserPreferencesModelCopyWithImpl;
@useResult
$Res call({
 String theme, bool notificationsEnabled, int nudgeDaysThreshold, bool friendAccountabilityEnabled, List<String> friendEmails, bool journalEnabled, bool interferenceLogEnabled, bool passFailUiEnabled, String? timezone
});




}
/// @nodoc
class _$UserPreferencesModelCopyWithImpl<$Res>
    implements $UserPreferencesModelCopyWith<$Res> {
  _$UserPreferencesModelCopyWithImpl(this._self, this._then);

  final UserPreferencesModel _self;
  final $Res Function(UserPreferencesModel) _then;

/// Create a copy of UserPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? notificationsEnabled = null,Object? nudgeDaysThreshold = null,Object? friendAccountabilityEnabled = null,Object? friendEmails = null,Object? journalEnabled = null,Object? interferenceLogEnabled = null,Object? passFailUiEnabled = null,Object? timezone = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeDaysThreshold: null == nudgeDaysThreshold ? _self.nudgeDaysThreshold : nudgeDaysThreshold // ignore: cast_nullable_to_non_nullable
as int,friendAccountabilityEnabled: null == friendAccountabilityEnabled ? _self.friendAccountabilityEnabled : friendAccountabilityEnabled // ignore: cast_nullable_to_non_nullable
as bool,friendEmails: null == friendEmails ? _self.friendEmails : friendEmails // ignore: cast_nullable_to_non_nullable
as List<String>,journalEnabled: null == journalEnabled ? _self.journalEnabled : journalEnabled // ignore: cast_nullable_to_non_nullable
as bool,interferenceLogEnabled: null == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool,passFailUiEnabled: null == passFailUiEnabled ? _self.passFailUiEnabled : passFailUiEnabled // ignore: cast_nullable_to_non_nullable
as bool,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferencesModel].
extension UserPreferencesModelPatterns on UserPreferencesModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferencesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferencesModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferencesModel value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferencesModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferencesModel() when $default != null:
return $default(_that.theme,_that.notificationsEnabled,_that.nudgeDaysThreshold,_that.friendAccountabilityEnabled,_that.friendEmails,_that.journalEnabled,_that.interferenceLogEnabled,_that.passFailUiEnabled,_that.timezone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesModel():
return $default(_that.theme,_that.notificationsEnabled,_that.nudgeDaysThreshold,_that.friendAccountabilityEnabled,_that.friendEmails,_that.journalEnabled,_that.interferenceLogEnabled,_that.passFailUiEnabled,_that.timezone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesModel() when $default != null:
return $default(_that.theme,_that.notificationsEnabled,_that.nudgeDaysThreshold,_that.friendAccountabilityEnabled,_that.friendEmails,_that.journalEnabled,_that.interferenceLogEnabled,_that.passFailUiEnabled,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc


class _UserPreferencesModel implements UserPreferencesModel {
  const _UserPreferencesModel({this.theme = 'system', this.notificationsEnabled = true, this.nudgeDaysThreshold = kNudgeDaysThreshold, this.friendAccountabilityEnabled = false, final  List<String> friendEmails = const <String>[], this.journalEnabled = false, this.interferenceLogEnabled = false, this.passFailUiEnabled = false, this.timezone}): _friendEmails = friendEmails;
  

@override@JsonKey() final  String theme;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  int nudgeDaysThreshold;
@override@JsonKey() final  bool friendAccountabilityEnabled;
 final  List<String> _friendEmails;
@override@JsonKey() List<String> get friendEmails {
  if (_friendEmails is EqualUnmodifiableListView) return _friendEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friendEmails);
}

@override@JsonKey() final  bool journalEnabled;
@override@JsonKey() final  bool interferenceLogEnabled;
@override@JsonKey() final  bool passFailUiEnabled;
@override final  String? timezone;

/// Create a copy of UserPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesModelCopyWith<_UserPreferencesModel> get copyWith => __$UserPreferencesModelCopyWithImpl<_UserPreferencesModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferencesModel&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other._friendEmails, _friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(_friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferencesModel(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesModelCopyWith<$Res> implements $UserPreferencesModelCopyWith<$Res> {
  factory _$UserPreferencesModelCopyWith(_UserPreferencesModel value, $Res Function(_UserPreferencesModel) _then) = __$UserPreferencesModelCopyWithImpl;
@override @useResult
$Res call({
 String theme, bool notificationsEnabled, int nudgeDaysThreshold, bool friendAccountabilityEnabled, List<String> friendEmails, bool journalEnabled, bool interferenceLogEnabled, bool passFailUiEnabled, String? timezone
});




}
/// @nodoc
class __$UserPreferencesModelCopyWithImpl<$Res>
    implements _$UserPreferencesModelCopyWith<$Res> {
  __$UserPreferencesModelCopyWithImpl(this._self, this._then);

  final _UserPreferencesModel _self;
  final $Res Function(_UserPreferencesModel) _then;

/// Create a copy of UserPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? notificationsEnabled = null,Object? nudgeDaysThreshold = null,Object? friendAccountabilityEnabled = null,Object? friendEmails = null,Object? journalEnabled = null,Object? interferenceLogEnabled = null,Object? passFailUiEnabled = null,Object? timezone = freezed,}) {
  return _then(_UserPreferencesModel(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeDaysThreshold: null == nudgeDaysThreshold ? _self.nudgeDaysThreshold : nudgeDaysThreshold // ignore: cast_nullable_to_non_nullable
as int,friendAccountabilityEnabled: null == friendAccountabilityEnabled ? _self.friendAccountabilityEnabled : friendAccountabilityEnabled // ignore: cast_nullable_to_non_nullable
as bool,friendEmails: null == friendEmails ? _self._friendEmails : friendEmails // ignore: cast_nullable_to_non_nullable
as List<String>,journalEnabled: null == journalEnabled ? _self.journalEnabled : journalEnabled // ignore: cast_nullable_to_non_nullable
as bool,interferenceLogEnabled: null == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool,passFailUiEnabled: null == passFailUiEnabled ? _self.passFailUiEnabled : passFailUiEnabled // ignore: cast_nullable_to_non_nullable
as bool,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
