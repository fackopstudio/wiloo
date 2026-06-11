// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_declaration_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExportDeclarationDto {

 String get format; String? get templateVersion;
/// Create a copy of ExportDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportDeclarationDtoCopyWith<ExportDeclarationDto> get copyWith => _$ExportDeclarationDtoCopyWithImpl<ExportDeclarationDto>(this as ExportDeclarationDto, _$identity);

  /// Serializes this ExportDeclarationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportDeclarationDto&&(identical(other.format, format) || other.format == format)&&(identical(other.templateVersion, templateVersion) || other.templateVersion == templateVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,templateVersion);

@override
String toString() {
  return 'ExportDeclarationDto(format: $format, templateVersion: $templateVersion)';
}


}

/// @nodoc
abstract mixin class $ExportDeclarationDtoCopyWith<$Res>  {
  factory $ExportDeclarationDtoCopyWith(ExportDeclarationDto value, $Res Function(ExportDeclarationDto) _then) = _$ExportDeclarationDtoCopyWithImpl;
@useResult
$Res call({
 String format, String? templateVersion
});




}
/// @nodoc
class _$ExportDeclarationDtoCopyWithImpl<$Res>
    implements $ExportDeclarationDtoCopyWith<$Res> {
  _$ExportDeclarationDtoCopyWithImpl(this._self, this._then);

  final ExportDeclarationDto _self;
  final $Res Function(ExportDeclarationDto) _then;

/// Create a copy of ExportDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? templateVersion = freezed,}) {
  return _then(_self.copyWith(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,templateVersion: freezed == templateVersion ? _self.templateVersion : templateVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportDeclarationDto].
extension ExportDeclarationDtoPatterns on ExportDeclarationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportDeclarationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportDeclarationDto value)  $default,){
final _that = this;
switch (_that) {
case _ExportDeclarationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportDeclarationDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExportDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String format,  String? templateVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportDeclarationDto() when $default != null:
return $default(_that.format,_that.templateVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String format,  String? templateVersion)  $default,) {final _that = this;
switch (_that) {
case _ExportDeclarationDto():
return $default(_that.format,_that.templateVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String format,  String? templateVersion)?  $default,) {final _that = this;
switch (_that) {
case _ExportDeclarationDto() when $default != null:
return $default(_that.format,_that.templateVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExportDeclarationDto implements ExportDeclarationDto {
  const _ExportDeclarationDto({required this.format, this.templateVersion});
  factory _ExportDeclarationDto.fromJson(Map<String, dynamic> json) => _$ExportDeclarationDtoFromJson(json);

@override final  String format;
@override final  String? templateVersion;

/// Create a copy of ExportDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportDeclarationDtoCopyWith<_ExportDeclarationDto> get copyWith => __$ExportDeclarationDtoCopyWithImpl<_ExportDeclarationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportDeclarationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportDeclarationDto&&(identical(other.format, format) || other.format == format)&&(identical(other.templateVersion, templateVersion) || other.templateVersion == templateVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,templateVersion);

@override
String toString() {
  return 'ExportDeclarationDto(format: $format, templateVersion: $templateVersion)';
}


}

/// @nodoc
abstract mixin class _$ExportDeclarationDtoCopyWith<$Res> implements $ExportDeclarationDtoCopyWith<$Res> {
  factory _$ExportDeclarationDtoCopyWith(_ExportDeclarationDto value, $Res Function(_ExportDeclarationDto) _then) = __$ExportDeclarationDtoCopyWithImpl;
@override @useResult
$Res call({
 String format, String? templateVersion
});




}
/// @nodoc
class __$ExportDeclarationDtoCopyWithImpl<$Res>
    implements _$ExportDeclarationDtoCopyWith<$Res> {
  __$ExportDeclarationDtoCopyWithImpl(this._self, this._then);

  final _ExportDeclarationDto _self;
  final $Res Function(_ExportDeclarationDto) _then;

/// Create a copy of ExportDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? templateVersion = freezed,}) {
  return _then(_ExportDeclarationDto(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,templateVersion: freezed == templateVersion ? _self.templateVersion : templateVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
