// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lab_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabModel {

 String get id; String get userId; String get name; String? get description; String get iconId; String get colorHex; DateTime get createdAt;
/// Create a copy of LabModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabModelCopyWith<LabModel> get copyWith => _$LabModelCopyWithImpl<LabModel>(this as LabModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconId, iconId) || other.iconId == iconId)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,iconId,colorHex,createdAt);

@override
String toString() {
  return 'LabModel(id: $id, userId: $userId, name: $name, description: $description, iconId: $iconId, colorHex: $colorHex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LabModelCopyWith<$Res>  {
  factory $LabModelCopyWith(LabModel value, $Res Function(LabModel) _then) = _$LabModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String? description, String iconId, String colorHex, DateTime createdAt
});




}
/// @nodoc
class _$LabModelCopyWithImpl<$Res>
    implements $LabModelCopyWith<$Res> {
  _$LabModelCopyWithImpl(this._self, this._then);

  final LabModel _self;
  final $Res Function(LabModel) _then;

/// Create a copy of LabModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = freezed,Object? iconId = null,Object? colorHex = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,iconId: null == iconId ? _self.iconId : iconId // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LabModel].
extension LabModelPatterns on LabModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabModel value)  $default,){
final _that = this;
switch (_that) {
case _LabModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabModel value)?  $default,){
final _that = this;
switch (_that) {
case _LabModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? description,  String iconId,  String colorHex,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.iconId,_that.colorHex,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? description,  String iconId,  String colorHex,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LabModel():
return $default(_that.id,_that.userId,_that.name,_that.description,_that.iconId,_that.colorHex,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String? description,  String iconId,  String colorHex,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LabModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.iconId,_that.colorHex,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _LabModel implements LabModel {
  const _LabModel({required this.id, required this.userId, required this.name, this.description, required this.iconId, required this.colorHex, required this.createdAt});
  

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  String? description;
@override final  String iconId;
@override final  String colorHex;
@override final  DateTime createdAt;

/// Create a copy of LabModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabModelCopyWith<_LabModel> get copyWith => __$LabModelCopyWithImpl<_LabModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconId, iconId) || other.iconId == iconId)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,iconId,colorHex,createdAt);

@override
String toString() {
  return 'LabModel(id: $id, userId: $userId, name: $name, description: $description, iconId: $iconId, colorHex: $colorHex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LabModelCopyWith<$Res> implements $LabModelCopyWith<$Res> {
  factory _$LabModelCopyWith(_LabModel value, $Res Function(_LabModel) _then) = __$LabModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String? description, String iconId, String colorHex, DateTime createdAt
});




}
/// @nodoc
class __$LabModelCopyWithImpl<$Res>
    implements _$LabModelCopyWith<$Res> {
  __$LabModelCopyWithImpl(this._self, this._then);

  final _LabModel _self;
  final $Res Function(_LabModel) _then;

/// Create a copy of LabModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = freezed,Object? iconId = null,Object? colorHex = null,Object? createdAt = null,}) {
  return _then(_LabModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,iconId: null == iconId ? _self.iconId : iconId // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
