// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_declaration_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerateDeclarationDto {

 String get declarationPeriodId; String get type; String? get ruleSetId; Map<String, Object?>? get metadata;
/// Create a copy of GenerateDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerateDeclarationDtoCopyWith<GenerateDeclarationDto> get copyWith => _$GenerateDeclarationDtoCopyWithImpl<GenerateDeclarationDto>(this as GenerateDeclarationDto, _$identity);

  /// Serializes this GenerateDeclarationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateDeclarationDto&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.type, type) || other.type == type)&&(identical(other.ruleSetId, ruleSetId) || other.ruleSetId == ruleSetId)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,declarationPeriodId,type,ruleSetId,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'GenerateDeclarationDto(declarationPeriodId: $declarationPeriodId, type: $type, ruleSetId: $ruleSetId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $GenerateDeclarationDtoCopyWith<$Res>  {
  factory $GenerateDeclarationDtoCopyWith(GenerateDeclarationDto value, $Res Function(GenerateDeclarationDto) _then) = _$GenerateDeclarationDtoCopyWithImpl;
@useResult
$Res call({
 String declarationPeriodId, String type, String? ruleSetId, Map<String, Object?>? metadata
});




}
/// @nodoc
class _$GenerateDeclarationDtoCopyWithImpl<$Res>
    implements $GenerateDeclarationDtoCopyWith<$Res> {
  _$GenerateDeclarationDtoCopyWithImpl(this._self, this._then);

  final GenerateDeclarationDto _self;
  final $Res Function(GenerateDeclarationDto) _then;

/// Create a copy of GenerateDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? declarationPeriodId = null,Object? type = null,Object? ruleSetId = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
declarationPeriodId: null == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,ruleSetId: freezed == ruleSetId ? _self.ruleSetId : ruleSetId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerateDeclarationDto].
extension GenerateDeclarationDtoPatterns on GenerateDeclarationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerateDeclarationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerateDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerateDeclarationDto value)  $default,){
final _that = this;
switch (_that) {
case _GenerateDeclarationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerateDeclarationDto value)?  $default,){
final _that = this;
switch (_that) {
case _GenerateDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String declarationPeriodId,  String type,  String? ruleSetId,  Map<String, Object?>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerateDeclarationDto() when $default != null:
return $default(_that.declarationPeriodId,_that.type,_that.ruleSetId,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String declarationPeriodId,  String type,  String? ruleSetId,  Map<String, Object?>? metadata)  $default,) {final _that = this;
switch (_that) {
case _GenerateDeclarationDto():
return $default(_that.declarationPeriodId,_that.type,_that.ruleSetId,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String declarationPeriodId,  String type,  String? ruleSetId,  Map<String, Object?>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _GenerateDeclarationDto() when $default != null:
return $default(_that.declarationPeriodId,_that.type,_that.ruleSetId,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerateDeclarationDto implements GenerateDeclarationDto {
  const _GenerateDeclarationDto({required this.declarationPeriodId, required this.type, this.ruleSetId, final  Map<String, Object?>? metadata}): _metadata = metadata;
  factory _GenerateDeclarationDto.fromJson(Map<String, dynamic> json) => _$GenerateDeclarationDtoFromJson(json);

@override final  String declarationPeriodId;
@override final  String type;
@override final  String? ruleSetId;
 final  Map<String, Object?>? _metadata;
@override Map<String, Object?>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of GenerateDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerateDeclarationDtoCopyWith<_GenerateDeclarationDto> get copyWith => __$GenerateDeclarationDtoCopyWithImpl<_GenerateDeclarationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerateDeclarationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateDeclarationDto&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.type, type) || other.type == type)&&(identical(other.ruleSetId, ruleSetId) || other.ruleSetId == ruleSetId)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,declarationPeriodId,type,ruleSetId,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'GenerateDeclarationDto(declarationPeriodId: $declarationPeriodId, type: $type, ruleSetId: $ruleSetId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$GenerateDeclarationDtoCopyWith<$Res> implements $GenerateDeclarationDtoCopyWith<$Res> {
  factory _$GenerateDeclarationDtoCopyWith(_GenerateDeclarationDto value, $Res Function(_GenerateDeclarationDto) _then) = __$GenerateDeclarationDtoCopyWithImpl;
@override @useResult
$Res call({
 String declarationPeriodId, String type, String? ruleSetId, Map<String, Object?>? metadata
});




}
/// @nodoc
class __$GenerateDeclarationDtoCopyWithImpl<$Res>
    implements _$GenerateDeclarationDtoCopyWith<$Res> {
  __$GenerateDeclarationDtoCopyWithImpl(this._self, this._then);

  final _GenerateDeclarationDto _self;
  final $Res Function(_GenerateDeclarationDto) _then;

/// Create a copy of GenerateDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? declarationPeriodId = null,Object? type = null,Object? ruleSetId = freezed,Object? metadata = freezed,}) {
  return _then(_GenerateDeclarationDto(
declarationPeriodId: null == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,ruleSetId: freezed == ruleSetId ? _self.ruleSetId : ruleSetId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}


}

// dart format on
