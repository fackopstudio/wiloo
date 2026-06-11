// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'declaration_line_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeclarationLineDto {

 Map<String, Object?> get raw;
/// Create a copy of DeclarationLineDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeclarationLineDtoCopyWith<DeclarationLineDto> get copyWith => _$DeclarationLineDtoCopyWithImpl<DeclarationLineDto>(this as DeclarationLineDto, _$identity);

  /// Serializes this DeclarationLineDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeclarationLineDto&&const DeepCollectionEquality().equals(other.raw, raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(raw));

@override
String toString() {
  return 'DeclarationLineDto(raw: $raw)';
}


}

/// @nodoc
abstract mixin class $DeclarationLineDtoCopyWith<$Res>  {
  factory $DeclarationLineDtoCopyWith(DeclarationLineDto value, $Res Function(DeclarationLineDto) _then) = _$DeclarationLineDtoCopyWithImpl;
@useResult
$Res call({
 Map<String, Object?> raw
});




}
/// @nodoc
class _$DeclarationLineDtoCopyWithImpl<$Res>
    implements $DeclarationLineDtoCopyWith<$Res> {
  _$DeclarationLineDtoCopyWithImpl(this._self, this._then);

  final DeclarationLineDto _self;
  final $Res Function(DeclarationLineDto) _then;

/// Create a copy of DeclarationLineDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raw = null,}) {
  return _then(_self.copyWith(
raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeclarationLineDto].
extension DeclarationLineDtoPatterns on DeclarationLineDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeclarationLineDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeclarationLineDto value)  $default,){
final _that = this;
switch (_that) {
case _DeclarationLineDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeclarationLineDto value)?  $default,){
final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Object?> raw)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
return $default(_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Object?> raw)  $default,) {final _that = this;
switch (_that) {
case _DeclarationLineDto():
return $default(_that.raw);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Object?> raw)?  $default,) {final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
return $default(_that.raw);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeclarationLineDto implements DeclarationLineDto {
  const _DeclarationLineDto({final  Map<String, Object?> raw = const <String, Object?>{}}): _raw = raw;
  factory _DeclarationLineDto.fromJson(Map<String, dynamic> json) => _$DeclarationLineDtoFromJson(json);

 final  Map<String, Object?> _raw;
@override@JsonKey() Map<String, Object?> get raw {
  if (_raw is EqualUnmodifiableMapView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_raw);
}


/// Create a copy of DeclarationLineDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclarationLineDtoCopyWith<_DeclarationLineDto> get copyWith => __$DeclarationLineDtoCopyWithImpl<_DeclarationLineDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeclarationLineDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclarationLineDto&&const DeepCollectionEquality().equals(other._raw, _raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_raw));

@override
String toString() {
  return 'DeclarationLineDto(raw: $raw)';
}


}

/// @nodoc
abstract mixin class _$DeclarationLineDtoCopyWith<$Res> implements $DeclarationLineDtoCopyWith<$Res> {
  factory _$DeclarationLineDtoCopyWith(_DeclarationLineDto value, $Res Function(_DeclarationLineDto) _then) = __$DeclarationLineDtoCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Object?> raw
});




}
/// @nodoc
class __$DeclarationLineDtoCopyWithImpl<$Res>
    implements _$DeclarationLineDtoCopyWith<$Res> {
  __$DeclarationLineDtoCopyWithImpl(this._self, this._then);

  final _DeclarationLineDto _self;
  final $Res Function(_DeclarationLineDto) _then;

/// Create a copy of DeclarationLineDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? raw = null,}) {
  return _then(_DeclarationLineDto(
raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
