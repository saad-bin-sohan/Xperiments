// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experiment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExperimentSubtask {

 String get id; String get name; int get order;
/// Create a copy of ExperimentSubtask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperimentSubtaskCopyWith<ExperimentSubtask> get copyWith => _$ExperimentSubtaskCopyWithImpl<ExperimentSubtask>(this as ExperimentSubtask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExperimentSubtask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order);

@override
String toString() {
  return 'ExperimentSubtask(id: $id, name: $name, order: $order)';
}


}

/// @nodoc
abstract mixin class $ExperimentSubtaskCopyWith<$Res>  {
  factory $ExperimentSubtaskCopyWith(ExperimentSubtask value, $Res Function(ExperimentSubtask) _then) = _$ExperimentSubtaskCopyWithImpl;
@useResult
$Res call({
 String id, String name, int order
});




}
/// @nodoc
class _$ExperimentSubtaskCopyWithImpl<$Res>
    implements $ExperimentSubtaskCopyWith<$Res> {
  _$ExperimentSubtaskCopyWithImpl(this._self, this._then);

  final ExperimentSubtask _self;
  final $Res Function(ExperimentSubtask) _then;

/// Create a copy of ExperimentSubtask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExperimentSubtask].
extension ExperimentSubtaskPatterns on ExperimentSubtask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExperimentSubtask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExperimentSubtask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExperimentSubtask value)  $default,){
final _that = this;
switch (_that) {
case _ExperimentSubtask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExperimentSubtask value)?  $default,){
final _that = this;
switch (_that) {
case _ExperimentSubtask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExperimentSubtask() when $default != null:
return $default(_that.id,_that.name,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int order)  $default,) {final _that = this;
switch (_that) {
case _ExperimentSubtask():
return $default(_that.id,_that.name,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int order)?  $default,) {final _that = this;
switch (_that) {
case _ExperimentSubtask() when $default != null:
return $default(_that.id,_that.name,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _ExperimentSubtask implements ExperimentSubtask {
  const _ExperimentSubtask({required this.id, required this.name, required this.order});
  

@override final  String id;
@override final  String name;
@override final  int order;

/// Create a copy of ExperimentSubtask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperimentSubtaskCopyWith<_ExperimentSubtask> get copyWith => __$ExperimentSubtaskCopyWithImpl<_ExperimentSubtask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExperimentSubtask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order);

@override
String toString() {
  return 'ExperimentSubtask(id: $id, name: $name, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ExperimentSubtaskCopyWith<$Res> implements $ExperimentSubtaskCopyWith<$Res> {
  factory _$ExperimentSubtaskCopyWith(_ExperimentSubtask value, $Res Function(_ExperimentSubtask) _then) = __$ExperimentSubtaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int order
});




}
/// @nodoc
class __$ExperimentSubtaskCopyWithImpl<$Res>
    implements _$ExperimentSubtaskCopyWith<$Res> {
  __$ExperimentSubtaskCopyWithImpl(this._self, this._then);

  final _ExperimentSubtask _self;
  final $Res Function(_ExperimentSubtask) _then;

/// Create a copy of ExperimentSubtask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,}) {
  return _then(_ExperimentSubtask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PauseWindow {

 DateTime get pausedAt; DateTime get resumedAt;
/// Create a copy of PauseWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PauseWindowCopyWith<PauseWindow> get copyWith => _$PauseWindowCopyWithImpl<PauseWindow>(this as PauseWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PauseWindow&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.resumedAt, resumedAt) || other.resumedAt == resumedAt));
}


@override
int get hashCode => Object.hash(runtimeType,pausedAt,resumedAt);

@override
String toString() {
  return 'PauseWindow(pausedAt: $pausedAt, resumedAt: $resumedAt)';
}


}

/// @nodoc
abstract mixin class $PauseWindowCopyWith<$Res>  {
  factory $PauseWindowCopyWith(PauseWindow value, $Res Function(PauseWindow) _then) = _$PauseWindowCopyWithImpl;
@useResult
$Res call({
 DateTime pausedAt, DateTime resumedAt
});




}
/// @nodoc
class _$PauseWindowCopyWithImpl<$Res>
    implements $PauseWindowCopyWith<$Res> {
  _$PauseWindowCopyWithImpl(this._self, this._then);

  final PauseWindow _self;
  final $Res Function(PauseWindow) _then;

/// Create a copy of PauseWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pausedAt = null,Object? resumedAt = null,}) {
  return _then(_self.copyWith(
pausedAt: null == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resumedAt: null == resumedAt ? _self.resumedAt : resumedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PauseWindow].
extension PauseWindowPatterns on PauseWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PauseWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PauseWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PauseWindow value)  $default,){
final _that = this;
switch (_that) {
case _PauseWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PauseWindow value)?  $default,){
final _that = this;
switch (_that) {
case _PauseWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime pausedAt,  DateTime resumedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PauseWindow() when $default != null:
return $default(_that.pausedAt,_that.resumedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime pausedAt,  DateTime resumedAt)  $default,) {final _that = this;
switch (_that) {
case _PauseWindow():
return $default(_that.pausedAt,_that.resumedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime pausedAt,  DateTime resumedAt)?  $default,) {final _that = this;
switch (_that) {
case _PauseWindow() when $default != null:
return $default(_that.pausedAt,_that.resumedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PauseWindow implements PauseWindow {
  const _PauseWindow({required this.pausedAt, required this.resumedAt});
  

@override final  DateTime pausedAt;
@override final  DateTime resumedAt;

/// Create a copy of PauseWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PauseWindowCopyWith<_PauseWindow> get copyWith => __$PauseWindowCopyWithImpl<_PauseWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PauseWindow&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.resumedAt, resumedAt) || other.resumedAt == resumedAt));
}


@override
int get hashCode => Object.hash(runtimeType,pausedAt,resumedAt);

@override
String toString() {
  return 'PauseWindow(pausedAt: $pausedAt, resumedAt: $resumedAt)';
}


}

/// @nodoc
abstract mixin class _$PauseWindowCopyWith<$Res> implements $PauseWindowCopyWith<$Res> {
  factory _$PauseWindowCopyWith(_PauseWindow value, $Res Function(_PauseWindow) _then) = __$PauseWindowCopyWithImpl;
@override @useResult
$Res call({
 DateTime pausedAt, DateTime resumedAt
});




}
/// @nodoc
class __$PauseWindowCopyWithImpl<$Res>
    implements _$PauseWindowCopyWith<$Res> {
  __$PauseWindowCopyWithImpl(this._self, this._then);

  final _PauseWindow _self;
  final $Res Function(_PauseWindow) _then;

/// Create a copy of PauseWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pausedAt = null,Object? resumedAt = null,}) {
  return _then(_PauseWindow(
pausedAt: null == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resumedAt: null == resumedAt ? _self.resumedAt : resumedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$Experiment {

 String get id; String get userId; String get labId; String get name; String? get hypothesis; String? get motivation; DateTime get startDate; ExperimentFrequency get frequency; List<int>? get customDays; bool get isOpenEnded; int? get durationValue; ExperimentDurationUnit? get durationUnit; DateTime? get endDate; ExperimentStatus get status; PassFailResult? get passFailResult; DateTime? get pausedAt; bool get remindersEnabled; String? get reminderTime; String? get interferenceNote; bool get interferenceLogEnabled; DateTime get createdAt; DateTime? get completedAt; String? get finalReflection; String? get lessonsLearned; List<ExperimentSubtask> get subtasks; List<PauseWindow> get pauseHistory;
/// Create a copy of Experiment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperimentCopyWith<Experiment> get copyWith => _$ExperimentCopyWithImpl<Experiment>(this as Experiment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Experiment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.labId, labId) || other.labId == labId)&&(identical(other.name, name) || other.name == name)&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.motivation, motivation) || other.motivation == motivation)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&const DeepCollectionEquality().equals(other.customDays, customDays)&&(identical(other.isOpenEnded, isOpenEnded) || other.isOpenEnded == isOpenEnded)&&(identical(other.durationValue, durationValue) || other.durationValue == durationValue)&&(identical(other.durationUnit, durationUnit) || other.durationUnit == durationUnit)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.passFailResult, passFailResult) || other.passFailResult == passFailResult)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.remindersEnabled, remindersEnabled) || other.remindersEnabled == remindersEnabled)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.interferenceNote, interferenceNote) || other.interferenceNote == interferenceNote)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.finalReflection, finalReflection) || other.finalReflection == finalReflection)&&(identical(other.lessonsLearned, lessonsLearned) || other.lessonsLearned == lessonsLearned)&&const DeepCollectionEquality().equals(other.subtasks, subtasks)&&const DeepCollectionEquality().equals(other.pauseHistory, pauseHistory));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,labId,name,hypothesis,motivation,startDate,frequency,const DeepCollectionEquality().hash(customDays),isOpenEnded,durationValue,durationUnit,endDate,status,passFailResult,pausedAt,remindersEnabled,reminderTime,interferenceNote,interferenceLogEnabled,createdAt,completedAt,finalReflection,lessonsLearned,const DeepCollectionEquality().hash(subtasks),const DeepCollectionEquality().hash(pauseHistory)]);

@override
String toString() {
  return 'Experiment(id: $id, userId: $userId, labId: $labId, name: $name, hypothesis: $hypothesis, motivation: $motivation, startDate: $startDate, frequency: $frequency, customDays: $customDays, isOpenEnded: $isOpenEnded, durationValue: $durationValue, durationUnit: $durationUnit, endDate: $endDate, status: $status, passFailResult: $passFailResult, pausedAt: $pausedAt, remindersEnabled: $remindersEnabled, reminderTime: $reminderTime, interferenceNote: $interferenceNote, interferenceLogEnabled: $interferenceLogEnabled, createdAt: $createdAt, completedAt: $completedAt, finalReflection: $finalReflection, lessonsLearned: $lessonsLearned, subtasks: $subtasks, pauseHistory: $pauseHistory)';
}


}

/// @nodoc
abstract mixin class $ExperimentCopyWith<$Res>  {
  factory $ExperimentCopyWith(Experiment value, $Res Function(Experiment) _then) = _$ExperimentCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String labId, String name, String? hypothesis, String? motivation, DateTime startDate, ExperimentFrequency frequency, List<int>? customDays, bool isOpenEnded, int? durationValue, ExperimentDurationUnit? durationUnit, DateTime? endDate, ExperimentStatus status, PassFailResult? passFailResult, DateTime? pausedAt, bool remindersEnabled, String? reminderTime, String? interferenceNote, bool interferenceLogEnabled, DateTime createdAt, DateTime? completedAt, String? finalReflection, String? lessonsLearned, List<ExperimentSubtask> subtasks, List<PauseWindow> pauseHistory
});




}
/// @nodoc
class _$ExperimentCopyWithImpl<$Res>
    implements $ExperimentCopyWith<$Res> {
  _$ExperimentCopyWithImpl(this._self, this._then);

  final Experiment _self;
  final $Res Function(Experiment) _then;

/// Create a copy of Experiment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? labId = null,Object? name = null,Object? hypothesis = freezed,Object? motivation = freezed,Object? startDate = null,Object? frequency = null,Object? customDays = freezed,Object? isOpenEnded = null,Object? durationValue = freezed,Object? durationUnit = freezed,Object? endDate = freezed,Object? status = null,Object? passFailResult = freezed,Object? pausedAt = freezed,Object? remindersEnabled = null,Object? reminderTime = freezed,Object? interferenceNote = freezed,Object? interferenceLogEnabled = null,Object? createdAt = null,Object? completedAt = freezed,Object? finalReflection = freezed,Object? lessonsLearned = freezed,Object? subtasks = null,Object? pauseHistory = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,labId: null == labId ? _self.labId : labId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hypothesis: freezed == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String?,motivation: freezed == motivation ? _self.motivation : motivation // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as ExperimentFrequency,customDays: freezed == customDays ? _self.customDays : customDays // ignore: cast_nullable_to_non_nullable
as List<int>?,isOpenEnded: null == isOpenEnded ? _self.isOpenEnded : isOpenEnded // ignore: cast_nullable_to_non_nullable
as bool,durationValue: freezed == durationValue ? _self.durationValue : durationValue // ignore: cast_nullable_to_non_nullable
as int?,durationUnit: freezed == durationUnit ? _self.durationUnit : durationUnit // ignore: cast_nullable_to_non_nullable
as ExperimentDurationUnit?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExperimentStatus,passFailResult: freezed == passFailResult ? _self.passFailResult : passFailResult // ignore: cast_nullable_to_non_nullable
as PassFailResult?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,interferenceNote: freezed == interferenceNote ? _self.interferenceNote : interferenceNote // ignore: cast_nullable_to_non_nullable
as String?,interferenceLogEnabled: null == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finalReflection: freezed == finalReflection ? _self.finalReflection : finalReflection // ignore: cast_nullable_to_non_nullable
as String?,lessonsLearned: freezed == lessonsLearned ? _self.lessonsLearned : lessonsLearned // ignore: cast_nullable_to_non_nullable
as String?,subtasks: null == subtasks ? _self.subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<ExperimentSubtask>,pauseHistory: null == pauseHistory ? _self.pauseHistory : pauseHistory // ignore: cast_nullable_to_non_nullable
as List<PauseWindow>,
  ));
}

}


/// Adds pattern-matching-related methods to [Experiment].
extension ExperimentPatterns on Experiment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Experiment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Experiment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Experiment value)  $default,){
final _that = this;
switch (_that) {
case _Experiment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Experiment value)?  $default,){
final _that = this;
switch (_that) {
case _Experiment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String labId,  String name,  String? hypothesis,  String? motivation,  DateTime startDate,  ExperimentFrequency frequency,  List<int>? customDays,  bool isOpenEnded,  int? durationValue,  ExperimentDurationUnit? durationUnit,  DateTime? endDate,  ExperimentStatus status,  PassFailResult? passFailResult,  DateTime? pausedAt,  bool remindersEnabled,  String? reminderTime,  String? interferenceNote,  bool interferenceLogEnabled,  DateTime createdAt,  DateTime? completedAt,  String? finalReflection,  String? lessonsLearned,  List<ExperimentSubtask> subtasks,  List<PauseWindow> pauseHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Experiment() when $default != null:
return $default(_that.id,_that.userId,_that.labId,_that.name,_that.hypothesis,_that.motivation,_that.startDate,_that.frequency,_that.customDays,_that.isOpenEnded,_that.durationValue,_that.durationUnit,_that.endDate,_that.status,_that.passFailResult,_that.pausedAt,_that.remindersEnabled,_that.reminderTime,_that.interferenceNote,_that.interferenceLogEnabled,_that.createdAt,_that.completedAt,_that.finalReflection,_that.lessonsLearned,_that.subtasks,_that.pauseHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String labId,  String name,  String? hypothesis,  String? motivation,  DateTime startDate,  ExperimentFrequency frequency,  List<int>? customDays,  bool isOpenEnded,  int? durationValue,  ExperimentDurationUnit? durationUnit,  DateTime? endDate,  ExperimentStatus status,  PassFailResult? passFailResult,  DateTime? pausedAt,  bool remindersEnabled,  String? reminderTime,  String? interferenceNote,  bool interferenceLogEnabled,  DateTime createdAt,  DateTime? completedAt,  String? finalReflection,  String? lessonsLearned,  List<ExperimentSubtask> subtasks,  List<PauseWindow> pauseHistory)  $default,) {final _that = this;
switch (_that) {
case _Experiment():
return $default(_that.id,_that.userId,_that.labId,_that.name,_that.hypothesis,_that.motivation,_that.startDate,_that.frequency,_that.customDays,_that.isOpenEnded,_that.durationValue,_that.durationUnit,_that.endDate,_that.status,_that.passFailResult,_that.pausedAt,_that.remindersEnabled,_that.reminderTime,_that.interferenceNote,_that.interferenceLogEnabled,_that.createdAt,_that.completedAt,_that.finalReflection,_that.lessonsLearned,_that.subtasks,_that.pauseHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String labId,  String name,  String? hypothesis,  String? motivation,  DateTime startDate,  ExperimentFrequency frequency,  List<int>? customDays,  bool isOpenEnded,  int? durationValue,  ExperimentDurationUnit? durationUnit,  DateTime? endDate,  ExperimentStatus status,  PassFailResult? passFailResult,  DateTime? pausedAt,  bool remindersEnabled,  String? reminderTime,  String? interferenceNote,  bool interferenceLogEnabled,  DateTime createdAt,  DateTime? completedAt,  String? finalReflection,  String? lessonsLearned,  List<ExperimentSubtask> subtasks,  List<PauseWindow> pauseHistory)?  $default,) {final _that = this;
switch (_that) {
case _Experiment() when $default != null:
return $default(_that.id,_that.userId,_that.labId,_that.name,_that.hypothesis,_that.motivation,_that.startDate,_that.frequency,_that.customDays,_that.isOpenEnded,_that.durationValue,_that.durationUnit,_that.endDate,_that.status,_that.passFailResult,_that.pausedAt,_that.remindersEnabled,_that.reminderTime,_that.interferenceNote,_that.interferenceLogEnabled,_that.createdAt,_that.completedAt,_that.finalReflection,_that.lessonsLearned,_that.subtasks,_that.pauseHistory);case _:
  return null;

}
}

}

/// @nodoc


class _Experiment implements Experiment {
  const _Experiment({required this.id, required this.userId, required this.labId, required this.name, this.hypothesis, this.motivation, required this.startDate, required this.frequency, final  List<int>? customDays, required this.isOpenEnded, this.durationValue, this.durationUnit, this.endDate, required this.status, this.passFailResult, this.pausedAt, required this.remindersEnabled, this.reminderTime, this.interferenceNote, required this.interferenceLogEnabled, required this.createdAt, this.completedAt, this.finalReflection, this.lessonsLearned, final  List<ExperimentSubtask> subtasks = const <ExperimentSubtask>[], final  List<PauseWindow> pauseHistory = const <PauseWindow>[]}): _customDays = customDays,_subtasks = subtasks,_pauseHistory = pauseHistory;
  

@override final  String id;
@override final  String userId;
@override final  String labId;
@override final  String name;
@override final  String? hypothesis;
@override final  String? motivation;
@override final  DateTime startDate;
@override final  ExperimentFrequency frequency;
 final  List<int>? _customDays;
@override List<int>? get customDays {
  final value = _customDays;
  if (value == null) return null;
  if (_customDays is EqualUnmodifiableListView) return _customDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool isOpenEnded;
@override final  int? durationValue;
@override final  ExperimentDurationUnit? durationUnit;
@override final  DateTime? endDate;
@override final  ExperimentStatus status;
@override final  PassFailResult? passFailResult;
@override final  DateTime? pausedAt;
@override final  bool remindersEnabled;
@override final  String? reminderTime;
@override final  String? interferenceNote;
@override final  bool interferenceLogEnabled;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;
@override final  String? finalReflection;
@override final  String? lessonsLearned;
 final  List<ExperimentSubtask> _subtasks;
@override@JsonKey() List<ExperimentSubtask> get subtasks {
  if (_subtasks is EqualUnmodifiableListView) return _subtasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subtasks);
}

 final  List<PauseWindow> _pauseHistory;
@override@JsonKey() List<PauseWindow> get pauseHistory {
  if (_pauseHistory is EqualUnmodifiableListView) return _pauseHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pauseHistory);
}


/// Create a copy of Experiment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperimentCopyWith<_Experiment> get copyWith => __$ExperimentCopyWithImpl<_Experiment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Experiment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.labId, labId) || other.labId == labId)&&(identical(other.name, name) || other.name == name)&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.motivation, motivation) || other.motivation == motivation)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&const DeepCollectionEquality().equals(other._customDays, _customDays)&&(identical(other.isOpenEnded, isOpenEnded) || other.isOpenEnded == isOpenEnded)&&(identical(other.durationValue, durationValue) || other.durationValue == durationValue)&&(identical(other.durationUnit, durationUnit) || other.durationUnit == durationUnit)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.passFailResult, passFailResult) || other.passFailResult == passFailResult)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.remindersEnabled, remindersEnabled) || other.remindersEnabled == remindersEnabled)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.interferenceNote, interferenceNote) || other.interferenceNote == interferenceNote)&&(identical(other.interferenceLogEnabled, interferenceLogEnabled) || other.interferenceLogEnabled == interferenceLogEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.finalReflection, finalReflection) || other.finalReflection == finalReflection)&&(identical(other.lessonsLearned, lessonsLearned) || other.lessonsLearned == lessonsLearned)&&const DeepCollectionEquality().equals(other._subtasks, _subtasks)&&const DeepCollectionEquality().equals(other._pauseHistory, _pauseHistory));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,labId,name,hypothesis,motivation,startDate,frequency,const DeepCollectionEquality().hash(_customDays),isOpenEnded,durationValue,durationUnit,endDate,status,passFailResult,pausedAt,remindersEnabled,reminderTime,interferenceNote,interferenceLogEnabled,createdAt,completedAt,finalReflection,lessonsLearned,const DeepCollectionEquality().hash(_subtasks),const DeepCollectionEquality().hash(_pauseHistory)]);

@override
String toString() {
  return 'Experiment(id: $id, userId: $userId, labId: $labId, name: $name, hypothesis: $hypothesis, motivation: $motivation, startDate: $startDate, frequency: $frequency, customDays: $customDays, isOpenEnded: $isOpenEnded, durationValue: $durationValue, durationUnit: $durationUnit, endDate: $endDate, status: $status, passFailResult: $passFailResult, pausedAt: $pausedAt, remindersEnabled: $remindersEnabled, reminderTime: $reminderTime, interferenceNote: $interferenceNote, interferenceLogEnabled: $interferenceLogEnabled, createdAt: $createdAt, completedAt: $completedAt, finalReflection: $finalReflection, lessonsLearned: $lessonsLearned, subtasks: $subtasks, pauseHistory: $pauseHistory)';
}


}

/// @nodoc
abstract mixin class _$ExperimentCopyWith<$Res> implements $ExperimentCopyWith<$Res> {
  factory _$ExperimentCopyWith(_Experiment value, $Res Function(_Experiment) _then) = __$ExperimentCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String labId, String name, String? hypothesis, String? motivation, DateTime startDate, ExperimentFrequency frequency, List<int>? customDays, bool isOpenEnded, int? durationValue, ExperimentDurationUnit? durationUnit, DateTime? endDate, ExperimentStatus status, PassFailResult? passFailResult, DateTime? pausedAt, bool remindersEnabled, String? reminderTime, String? interferenceNote, bool interferenceLogEnabled, DateTime createdAt, DateTime? completedAt, String? finalReflection, String? lessonsLearned, List<ExperimentSubtask> subtasks, List<PauseWindow> pauseHistory
});




}
/// @nodoc
class __$ExperimentCopyWithImpl<$Res>
    implements _$ExperimentCopyWith<$Res> {
  __$ExperimentCopyWithImpl(this._self, this._then);

  final _Experiment _self;
  final $Res Function(_Experiment) _then;

/// Create a copy of Experiment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? labId = null,Object? name = null,Object? hypothesis = freezed,Object? motivation = freezed,Object? startDate = null,Object? frequency = null,Object? customDays = freezed,Object? isOpenEnded = null,Object? durationValue = freezed,Object? durationUnit = freezed,Object? endDate = freezed,Object? status = null,Object? passFailResult = freezed,Object? pausedAt = freezed,Object? remindersEnabled = null,Object? reminderTime = freezed,Object? interferenceNote = freezed,Object? interferenceLogEnabled = null,Object? createdAt = null,Object? completedAt = freezed,Object? finalReflection = freezed,Object? lessonsLearned = freezed,Object? subtasks = null,Object? pauseHistory = null,}) {
  return _then(_Experiment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,labId: null == labId ? _self.labId : labId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hypothesis: freezed == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String?,motivation: freezed == motivation ? _self.motivation : motivation // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as ExperimentFrequency,customDays: freezed == customDays ? _self._customDays : customDays // ignore: cast_nullable_to_non_nullable
as List<int>?,isOpenEnded: null == isOpenEnded ? _self.isOpenEnded : isOpenEnded // ignore: cast_nullable_to_non_nullable
as bool,durationValue: freezed == durationValue ? _self.durationValue : durationValue // ignore: cast_nullable_to_non_nullable
as int?,durationUnit: freezed == durationUnit ? _self.durationUnit : durationUnit // ignore: cast_nullable_to_non_nullable
as ExperimentDurationUnit?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExperimentStatus,passFailResult: freezed == passFailResult ? _self.passFailResult : passFailResult // ignore: cast_nullable_to_non_nullable
as PassFailResult?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: freezed == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String?,interferenceNote: freezed == interferenceNote ? _self.interferenceNote : interferenceNote // ignore: cast_nullable_to_non_nullable
as String?,interferenceLogEnabled: null == interferenceLogEnabled ? _self.interferenceLogEnabled : interferenceLogEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finalReflection: freezed == finalReflection ? _self.finalReflection : finalReflection // ignore: cast_nullable_to_non_nullable
as String?,lessonsLearned: freezed == lessonsLearned ? _self.lessonsLearned : lessonsLearned // ignore: cast_nullable_to_non_nullable
as String?,subtasks: null == subtasks ? _self._subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<ExperimentSubtask>,pauseHistory: null == pauseHistory ? _self._pauseHistory : pauseHistory // ignore: cast_nullable_to_non_nullable
as List<PauseWindow>,
  ));
}


}

// dart format on
