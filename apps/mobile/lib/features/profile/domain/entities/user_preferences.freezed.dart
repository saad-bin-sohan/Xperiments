// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserPreferences {

 AppThemePreference get theme; bool get notificationsEnabled; int get nudgeDaysThreshold; bool get friendAccountabilityEnabled; List<String> get friendEmails; bool get journalEnabled; bool get interferenceLogEnabled; bool get passFailUiEnabled; String? get timezone;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other.friendEmails, friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferences(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
 AppThemePreference theme, bool notificationsEnabled, int nudgeDaysThreshold, bool friendAccountabilityEnabled, List<String> friendEmails, bool journalEnabled, bool interferenceLogEnabled, bool passFailUiEnabled, String? timezone
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? notificationsEnabled = null,Object? nudgeDaysThreshold = null,Object? friendAccountabilityEnabled = null,Object? friendEmails = null,Object? journalEnabled = null,Object? interferenceLogEnabled = null,Object? passFailUiEnabled = null,Object? timezone = freezed,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppThemePreference theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppThemePreference theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppThemePreference theme,  bool notificationsEnabled,  int nudgeDaysThreshold,  bool friendAccountabilityEnabled,  List<String> friendEmails,  bool journalEnabled,  bool interferenceLogEnabled,  bool passFailUiEnabled,  String? timezone)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.theme,_that.notificationsEnabled,_that.nudgeDaysThreshold,_that.friendAccountabilityEnabled,_that.friendEmails,_that.journalEnabled,_that.interferenceLogEnabled,_that.passFailUiEnabled,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc


class _UserPreferences implements UserPreferences {
  const _UserPreferences({this.theme = AppThemePreference.system, this.notificationsEnabled = true, this.nudgeDaysThreshold = 7, this.friendAccountabilityEnabled = false, final  List<String> friendEmails = const <String>[], this.journalEnabled = false, this.interferenceLogEnabled = false, this.passFailUiEnabled = false, this.timezone}): _friendEmails = friendEmails;
  

@override@JsonKey() final  AppThemePreference theme;
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

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other._friendEmails, _friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(_friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferences(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
 AppThemePreference theme, bool notificationsEnabled, int nudgeDaysThreshold, bool friendAccountabilityEnabled, List<String> friendEmails, bool journalEnabled, bool interferenceLogEnabled, bool passFailUiEnabled, String? timezone
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? notificationsEnabled = null,Object? nudgeDaysThreshold = null,Object? friendAccountabilityEnabled = null,Object? friendEmails = null,Object? journalEnabled = null,Object? interferenceLogEnabled = null,Object? passFailUiEnabled = null,Object? timezone = freezed,}) {
  return _then(_UserPreferences(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
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

/// @nodoc
mixin _$UserPreferencesPatch {

 AppThemePreference? get theme; bool? get notificationsEnabled; int? get nudgeDaysThreshold; bool? get friendAccountabilityEnabled; List<String>? get friendEmails; bool? get journalEnabled; bool? get interferenceLogEnabled; bool? get passFailUiEnabled; String? get timezone;
/// Create a copy of UserPreferencesPatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesPatchCopyWith<UserPreferencesPatch> get copyWith => _$UserPreferencesPatchCopyWithImpl<UserPreferencesPatch>(this as UserPreferencesPatch, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferencesPatch&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other.friendEmails, friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferencesPatch(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesPatchCopyWith<$Res>  {
  factory $UserPreferencesPatchCopyWith(UserPreferencesPatch value, $Res Function(UserPreferencesPatch) _then) = _$UserPreferencesPatchCopyWithImpl;
@useResult
$Res call({
 AppThemePreference? theme, bool? notificationsEnabled, int? nudgeDaysThreshold, bool? friendAccountabilityEnabled, List<String>? friendEmails, bool? journalEnabled, bool? interferenceLogEnabled, bool? passFailUiEnabled, String? timezone
});




}
/// @nodoc
class _$UserPreferencesPatchCopyWithImpl<$Res>
    implements $UserPreferencesPatchCopyWith<$Res> {
  _$UserPreferencesPatchCopyWithImpl(this._self, this._then);

  final UserPreferencesPatch _self;
  final $Res Function(UserPreferencesPatch) _then;

/// Create a copy of UserPreferencesPatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = freezed,Object? notificationsEnabled = freezed,Object? nudgeDaysThreshold = freezed,Object? friendAccountabilityEnabled = freezed,Object? friendEmails = freezed,Object? journalEnabled = freezed,Object? interferenceLogEnabled = freezed,Object? passFailUiEnabled = freezed,Object? timezone = freezed,}) {
  return _then(_self.copyWith(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nudgeDaysThreshold: freezed == nudgeDaysThreshold ? _self.nudgeDaysThreshold : nudgeDaysThreshold // ignore: cast_nullable_to_non_nullable
as int?,friendAccountabilityEnabled: freezed == friendAccountabilityEnabled ? _self.friendAccountabilityEnabled : friendAccountabilityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,friendEmails: freezed == friendEmails ? _self.friendEmails : friendEmails // ignore: cast_nullable_to_non_nullable
as List<String>?,journalEnabled: freezed == journalEnabled ? _self.journalEnabled : journalEnabled // ignore: cast_nullable_to_non_nullable
as bool?,interferenceLogEnabled: freezed == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool?,passFailUiEnabled: freezed == passFailUiEnabled ? _self.passFailUiEnabled : passFailUiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferencesPatch].
extension UserPreferencesPatchPatterns on UserPreferencesPatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferencesPatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferencesPatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferencesPatch value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesPatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferencesPatch value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesPatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppThemePreference? theme,  bool? notificationsEnabled,  int? nudgeDaysThreshold,  bool? friendAccountabilityEnabled,  List<String>? friendEmails,  bool? journalEnabled,  bool? interferenceLogEnabled,  bool? passFailUiEnabled,  String? timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferencesPatch() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppThemePreference? theme,  bool? notificationsEnabled,  int? nudgeDaysThreshold,  bool? friendAccountabilityEnabled,  List<String>? friendEmails,  bool? journalEnabled,  bool? interferenceLogEnabled,  bool? passFailUiEnabled,  String? timezone)  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesPatch():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppThemePreference? theme,  bool? notificationsEnabled,  int? nudgeDaysThreshold,  bool? friendAccountabilityEnabled,  List<String>? friendEmails,  bool? journalEnabled,  bool? interferenceLogEnabled,  bool? passFailUiEnabled,  String? timezone)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesPatch() when $default != null:
return $default(_that.theme,_that.notificationsEnabled,_that.nudgeDaysThreshold,_that.friendAccountabilityEnabled,_that.friendEmails,_that.journalEnabled,_that.interferenceLogEnabled,_that.passFailUiEnabled,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc


class _UserPreferencesPatch implements UserPreferencesPatch {
  const _UserPreferencesPatch({this.theme, this.notificationsEnabled, this.nudgeDaysThreshold, this.friendAccountabilityEnabled, final  List<String>? friendEmails, this.journalEnabled, this.interferenceLogEnabled, this.passFailUiEnabled, this.timezone}): _friendEmails = friendEmails;
  

@override final  AppThemePreference? theme;
@override final  bool? notificationsEnabled;
@override final  int? nudgeDaysThreshold;
@override final  bool? friendAccountabilityEnabled;
 final  List<String>? _friendEmails;
@override List<String>? get friendEmails {
  final value = _friendEmails;
  if (value == null) return null;
  if (_friendEmails is EqualUnmodifiableListView) return _friendEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? journalEnabled;
@override final  bool? interferenceLogEnabled;
@override final  bool? passFailUiEnabled;
@override final  String? timezone;

/// Create a copy of UserPreferencesPatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesPatchCopyWith<_UserPreferencesPatch> get copyWith => __$UserPreferencesPatchCopyWithImpl<_UserPreferencesPatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferencesPatch&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeDaysThreshold, nudgeDaysThreshold) || other.nudgeDaysThreshold == nudgeDaysThreshold)&&(identical(other.friendAccountabilityEnabled, friendAccountabilityEnabled) || other.friendAccountabilityEnabled == friendAccountabilityEnabled)&&const DeepCollectionEquality().equals(other._friendEmails, _friendEmails)&&(identical(other.journalEnabled, journalEnabled) || other.journalEnabled == journalEnabled)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.passFailUiEnabled, passFailUiEnabled) || other.passFailUiEnabled == passFailUiEnabled)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}


@override
int get hashCode => Object.hash(runtimeType,theme,notificationsEnabled,nudgeDaysThreshold,friendAccountabilityEnabled,const DeepCollectionEquality().hash(_friendEmails),journalEnabled,interferenceLogEnabled,passFailUiEnabled,timezone);

@override
String toString() {
  return 'UserPreferencesPatch(theme: $theme, notificationsEnabled: $notificationsEnabled, nudgeDaysThreshold: $nudgeDaysThreshold, friendAccountabilityEnabled: $friendAccountabilityEnabled, friendEmails: $friendEmails, journalEnabled: $journalEnabled, interferenceLogEnabled: $interferenceLogEnabled, passFailUiEnabled: $passFailUiEnabled, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesPatchCopyWith<$Res> implements $UserPreferencesPatchCopyWith<$Res> {
  factory _$UserPreferencesPatchCopyWith(_UserPreferencesPatch value, $Res Function(_UserPreferencesPatch) _then) = __$UserPreferencesPatchCopyWithImpl;
@override @useResult
$Res call({
 AppThemePreference? theme, bool? notificationsEnabled, int? nudgeDaysThreshold, bool? friendAccountabilityEnabled, List<String>? friendEmails, bool? journalEnabled, bool? interferenceLogEnabled, bool? passFailUiEnabled, String? timezone
});




}
/// @nodoc
class __$UserPreferencesPatchCopyWithImpl<$Res>
    implements _$UserPreferencesPatchCopyWith<$Res> {
  __$UserPreferencesPatchCopyWithImpl(this._self, this._then);

  final _UserPreferencesPatch _self;
  final $Res Function(_UserPreferencesPatch) _then;

/// Create a copy of UserPreferencesPatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = freezed,Object? notificationsEnabled = freezed,Object? nudgeDaysThreshold = freezed,Object? friendAccountabilityEnabled = freezed,Object? friendEmails = freezed,Object? journalEnabled = freezed,Object? interferenceLogEnabled = freezed,Object? passFailUiEnabled = freezed,Object? timezone = freezed,}) {
  return _then(_UserPreferencesPatch(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,nudgeDaysThreshold: freezed == nudgeDaysThreshold ? _self.nudgeDaysThreshold : nudgeDaysThreshold // ignore: cast_nullable_to_non_nullable
as int?,friendAccountabilityEnabled: freezed == friendAccountabilityEnabled ? _self.friendAccountabilityEnabled : friendAccountabilityEnabled // ignore: cast_nullable_to_non_nullable
as bool?,friendEmails: freezed == friendEmails ? _self._friendEmails : friendEmails // ignore: cast_nullable_to_non_nullable
as List<String>?,journalEnabled: freezed == journalEnabled ? _self.journalEnabled : journalEnabled // ignore: cast_nullable_to_non_nullable
as bool?,interferenceLogEnabled: freezed == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool?,passFailUiEnabled: freezed == passFailUiEnabled ? _self.passFailUiEnabled : passFailUiEnabled // ignore: cast_nullable_to_non_nullable
as bool?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
