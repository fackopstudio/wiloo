// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'declaration_export_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeclarationExportDto {

 String? get id; String? get declarationId; String? get format; String? get fileName; String? get storageKey; String? get checksum; String? get generatedBy; String? get generatedAt; String? get status; Map<String, Object?> get raw;
/// Create a copy of DeclarationExportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeclarationExportDtoCopyWith<DeclarationExportDto> get copyWith => _$DeclarationExportDtoCopyWithImpl<DeclarationExportDto>(this as DeclarationExportDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeclarationExportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.declarationId, declarationId) || other.declarationId == declarationId)&&(identical(other.format, format) || other.format == format)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.storageKey, storageKey) || other.storageKey == storageKey)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.generatedBy, generatedBy) || other.generatedBy == generatedBy)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.raw, raw));
}


@override
int get hashCode => Object.hash(runtimeType,id,declarationId,format,fileName,storageKey,checksum,generatedBy,generatedAt,status,const DeepCollectionEquality().hash(raw));

@override
String toString() {
  return 'DeclarationExportDto(id: $id, declarationId: $declarationId, format: $format, fileName: $fileName, storageKey: $storageKey, checksum: $checksum, generatedBy: $generatedBy, generatedAt: $generatedAt, status: $status, raw: $raw)';
}


}

/// @nodoc
abstract mixin class $DeclarationExportDtoCopyWith<$Res>  {
  factory $DeclarationExportDtoCopyWith(DeclarationExportDto value, $Res Function(DeclarationExportDto) _then) = _$DeclarationExportDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String? declarationId, String? format, String? fileName, String? storageKey, String? checksum, String? generatedBy, String? generatedAt, String? status, Map<String, Object?> raw
});




}
/// @nodoc
class _$DeclarationExportDtoCopyWithImpl<$Res>
    implements $DeclarationExportDtoCopyWith<$Res> {
  _$DeclarationExportDtoCopyWithImpl(this._self, this._then);

  final DeclarationExportDto _self;
  final $Res Function(DeclarationExportDto) _then;

/// Create a copy of DeclarationExportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? declarationId = freezed,Object? format = freezed,Object? fileName = freezed,Object? storageKey = freezed,Object? checksum = freezed,Object? generatedBy = freezed,Object? generatedAt = freezed,Object? status = freezed,Object? raw = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,declarationId: freezed == declarationId ? _self.declarationId : declarationId // ignore: cast_nullable_to_non_nullable
as String?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,storageKey: freezed == storageKey ? _self.storageKey : storageKey // ignore: cast_nullable_to_non_nullable
as String?,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,generatedBy: freezed == generatedBy ? _self.generatedBy : generatedBy // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeclarationExportDto].
extension DeclarationExportDtoPatterns on DeclarationExportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeclarationExportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeclarationExportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeclarationExportDto value)  $default,){
final _that = this;
switch (_that) {
case _DeclarationExportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeclarationExportDto value)?  $default,){
final _that = this;
switch (_that) {
case _DeclarationExportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? declarationId,  String? format,  String? fileName,  String? storageKey,  String? checksum,  String? generatedBy,  String? generatedAt,  String? status,  Map<String, Object?> raw)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeclarationExportDto() when $default != null:
return $default(_that.id,_that.declarationId,_that.format,_that.fileName,_that.storageKey,_that.checksum,_that.generatedBy,_that.generatedAt,_that.status,_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? declarationId,  String? format,  String? fileName,  String? storageKey,  String? checksum,  String? generatedBy,  String? generatedAt,  String? status,  Map<String, Object?> raw)  $default,) {final _that = this;
switch (_that) {
case _DeclarationExportDto():
return $default(_that.id,_that.declarationId,_that.format,_that.fileName,_that.storageKey,_that.checksum,_that.generatedBy,_that.generatedAt,_that.status,_that.raw);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? declarationId,  String? format,  String? fileName,  String? storageKey,  String? checksum,  String? generatedBy,  String? generatedAt,  String? status,  Map<String, Object?> raw)?  $default,) {final _that = this;
switch (_that) {
case _DeclarationExportDto() when $default != null:
return $default(_that.id,_that.declarationId,_that.format,_that.fileName,_that.storageKey,_that.checksum,_that.generatedBy,_that.generatedAt,_that.status,_that.raw);case _:
  return null;

}
}

}

/// @nodoc


class _DeclarationExportDto extends DeclarationExportDto {
  const _DeclarationExportDto({this.id, this.declarationId, this.format, this.fileName, this.storageKey, this.checksum, this.generatedBy, this.generatedAt, this.status, final  Map<String, Object?> raw = const <String, Object?>{}}): _raw = raw,super._();
  

@override final  String? id;
@override final  String? declarationId;
@override final  String? format;
@override final  String? fileName;
@override final  String? storageKey;
@override final  String? checksum;
@override final  String? generatedBy;
@override final  String? generatedAt;
@override final  String? status;
 final  Map<String, Object?> _raw;
@override@JsonKey() Map<String, Object?> get raw {
  if (_raw is EqualUnmodifiableMapView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_raw);
}


/// Create a copy of DeclarationExportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclarationExportDtoCopyWith<_DeclarationExportDto> get copyWith => __$DeclarationExportDtoCopyWithImpl<_DeclarationExportDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclarationExportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.declarationId, declarationId) || other.declarationId == declarationId)&&(identical(other.format, format) || other.format == format)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.storageKey, storageKey) || other.storageKey == storageKey)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.generatedBy, generatedBy) || other.generatedBy == generatedBy)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._raw, _raw));
}


@override
int get hashCode => Object.hash(runtimeType,id,declarationId,format,fileName,storageKey,checksum,generatedBy,generatedAt,status,const DeepCollectionEquality().hash(_raw));

@override
String toString() {
  return 'DeclarationExportDto(id: $id, declarationId: $declarationId, format: $format, fileName: $fileName, storageKey: $storageKey, checksum: $checksum, generatedBy: $generatedBy, generatedAt: $generatedAt, status: $status, raw: $raw)';
}


}

/// @nodoc
abstract mixin class _$DeclarationExportDtoCopyWith<$Res> implements $DeclarationExportDtoCopyWith<$Res> {
  factory _$DeclarationExportDtoCopyWith(_DeclarationExportDto value, $Res Function(_DeclarationExportDto) _then) = __$DeclarationExportDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? declarationId, String? format, String? fileName, String? storageKey, String? checksum, String? generatedBy, String? generatedAt, String? status, Map<String, Object?> raw
});




}
/// @nodoc
class __$DeclarationExportDtoCopyWithImpl<$Res>
    implements _$DeclarationExportDtoCopyWith<$Res> {
  __$DeclarationExportDtoCopyWithImpl(this._self, this._then);

  final _DeclarationExportDto _self;
  final $Res Function(_DeclarationExportDto) _then;

/// Create a copy of DeclarationExportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? declarationId = freezed,Object? format = freezed,Object? fileName = freezed,Object? storageKey = freezed,Object? checksum = freezed,Object? generatedBy = freezed,Object? generatedAt = freezed,Object? status = freezed,Object? raw = null,}) {
  return _then(_DeclarationExportDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,declarationId: freezed == declarationId ? _self.declarationId : declarationId // ignore: cast_nullable_to_non_nullable
as String?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,storageKey: freezed == storageKey ? _self.storageKey : storageKey // ignore: cast_nullable_to_non_nullable
as String?,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,generatedBy: freezed == generatedBy ? _self.generatedBy : generatedBy // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
