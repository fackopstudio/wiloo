// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_declarations_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListDeclarationsQueryDto {

 String? get declarationPeriodId; String? get companyId; String? get type; String? get status;
/// Create a copy of ListDeclarationsQueryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListDeclarationsQueryDtoCopyWith<ListDeclarationsQueryDto> get copyWith => _$ListDeclarationsQueryDtoCopyWithImpl<ListDeclarationsQueryDto>(this as ListDeclarationsQueryDto, _$identity);

  /// Serializes this ListDeclarationsQueryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListDeclarationsQueryDto&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,declarationPeriodId,companyId,type,status);

@override
String toString() {
  return 'ListDeclarationsQueryDto(declarationPeriodId: $declarationPeriodId, companyId: $companyId, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class $ListDeclarationsQueryDtoCopyWith<$Res>  {
  factory $ListDeclarationsQueryDtoCopyWith(ListDeclarationsQueryDto value, $Res Function(ListDeclarationsQueryDto) _then) = _$ListDeclarationsQueryDtoCopyWithImpl;
@useResult
$Res call({
 String? declarationPeriodId, String? companyId, String? type, String? status
});




}
/// @nodoc
class _$ListDeclarationsQueryDtoCopyWithImpl<$Res>
    implements $ListDeclarationsQueryDtoCopyWith<$Res> {
  _$ListDeclarationsQueryDtoCopyWithImpl(this._self, this._then);

  final ListDeclarationsQueryDto _self;
  final $Res Function(ListDeclarationsQueryDto) _then;

/// Create a copy of ListDeclarationsQueryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? declarationPeriodId = freezed,Object? companyId = freezed,Object? type = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
declarationPeriodId: freezed == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String?,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListDeclarationsQueryDto].
extension ListDeclarationsQueryDtoPatterns on ListDeclarationsQueryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListDeclarationsQueryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListDeclarationsQueryDto value)  $default,){
final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListDeclarationsQueryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? declarationPeriodId,  String? companyId,  String? type,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto() when $default != null:
return $default(_that.declarationPeriodId,_that.companyId,_that.type,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? declarationPeriodId,  String? companyId,  String? type,  String? status)  $default,) {final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto():
return $default(_that.declarationPeriodId,_that.companyId,_that.type,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? declarationPeriodId,  String? companyId,  String? type,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _ListDeclarationsQueryDto() when $default != null:
return $default(_that.declarationPeriodId,_that.companyId,_that.type,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListDeclarationsQueryDto implements ListDeclarationsQueryDto {
  const _ListDeclarationsQueryDto({this.declarationPeriodId, this.companyId, this.type, this.status});
  factory _ListDeclarationsQueryDto.fromJson(Map<String, dynamic> json) => _$ListDeclarationsQueryDtoFromJson(json);

@override final  String? declarationPeriodId;
@override final  String? companyId;
@override final  String? type;
@override final  String? status;

/// Create a copy of ListDeclarationsQueryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListDeclarationsQueryDtoCopyWith<_ListDeclarationsQueryDto> get copyWith => __$ListDeclarationsQueryDtoCopyWithImpl<_ListDeclarationsQueryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListDeclarationsQueryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListDeclarationsQueryDto&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,declarationPeriodId,companyId,type,status);

@override
String toString() {
  return 'ListDeclarationsQueryDto(declarationPeriodId: $declarationPeriodId, companyId: $companyId, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ListDeclarationsQueryDtoCopyWith<$Res> implements $ListDeclarationsQueryDtoCopyWith<$Res> {
  factory _$ListDeclarationsQueryDtoCopyWith(_ListDeclarationsQueryDto value, $Res Function(_ListDeclarationsQueryDto) _then) = __$ListDeclarationsQueryDtoCopyWithImpl;
@override @useResult
$Res call({
 String? declarationPeriodId, String? companyId, String? type, String? status
});




}
/// @nodoc
class __$ListDeclarationsQueryDtoCopyWithImpl<$Res>
    implements _$ListDeclarationsQueryDtoCopyWith<$Res> {
  __$ListDeclarationsQueryDtoCopyWithImpl(this._self, this._then);

  final _ListDeclarationsQueryDto _self;
  final $Res Function(_ListDeclarationsQueryDto) _then;

/// Create a copy of ListDeclarationsQueryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? declarationPeriodId = freezed,Object? companyId = freezed,Object? type = freezed,Object? status = freezed,}) {
  return _then(_ListDeclarationsQueryDto(
declarationPeriodId: freezed == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String?,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
