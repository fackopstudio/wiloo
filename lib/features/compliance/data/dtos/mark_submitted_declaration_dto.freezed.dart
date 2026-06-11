// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mark_submitted_declaration_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarkSubmittedDeclarationDto {

 String? get submittedAt; String? get notes; SupportingDocumentDto? get supportingDocument;
/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkSubmittedDeclarationDtoCopyWith<MarkSubmittedDeclarationDto> get copyWith => _$MarkSubmittedDeclarationDtoCopyWithImpl<MarkSubmittedDeclarationDto>(this as MarkSubmittedDeclarationDto, _$identity);

  /// Serializes this MarkSubmittedDeclarationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkSubmittedDeclarationDto&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.supportingDocument, supportingDocument) || other.supportingDocument == supportingDocument));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submittedAt,notes,supportingDocument);

@override
String toString() {
  return 'MarkSubmittedDeclarationDto(submittedAt: $submittedAt, notes: $notes, supportingDocument: $supportingDocument)';
}


}

/// @nodoc
abstract mixin class $MarkSubmittedDeclarationDtoCopyWith<$Res>  {
  factory $MarkSubmittedDeclarationDtoCopyWith(MarkSubmittedDeclarationDto value, $Res Function(MarkSubmittedDeclarationDto) _then) = _$MarkSubmittedDeclarationDtoCopyWithImpl;
@useResult
$Res call({
 String? submittedAt, String? notes, SupportingDocumentDto? supportingDocument
});


$SupportingDocumentDtoCopyWith<$Res>? get supportingDocument;

}
/// @nodoc
class _$MarkSubmittedDeclarationDtoCopyWithImpl<$Res>
    implements $MarkSubmittedDeclarationDtoCopyWith<$Res> {
  _$MarkSubmittedDeclarationDtoCopyWithImpl(this._self, this._then);

  final MarkSubmittedDeclarationDto _self;
  final $Res Function(MarkSubmittedDeclarationDto) _then;

/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submittedAt = freezed,Object? notes = freezed,Object? supportingDocument = freezed,}) {
  return _then(_self.copyWith(
submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,supportingDocument: freezed == supportingDocument ? _self.supportingDocument : supportingDocument // ignore: cast_nullable_to_non_nullable
as SupportingDocumentDto?,
  ));
}
/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportingDocumentDtoCopyWith<$Res>? get supportingDocument {
    if (_self.supportingDocument == null) {
    return null;
  }

  return $SupportingDocumentDtoCopyWith<$Res>(_self.supportingDocument!, (value) {
    return _then(_self.copyWith(supportingDocument: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarkSubmittedDeclarationDto].
extension MarkSubmittedDeclarationDtoPatterns on MarkSubmittedDeclarationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkSubmittedDeclarationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkSubmittedDeclarationDto value)  $default,){
final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkSubmittedDeclarationDto value)?  $default,){
final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? submittedAt,  String? notes,  SupportingDocumentDto? supportingDocument)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto() when $default != null:
return $default(_that.submittedAt,_that.notes,_that.supportingDocument);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? submittedAt,  String? notes,  SupportingDocumentDto? supportingDocument)  $default,) {final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto():
return $default(_that.submittedAt,_that.notes,_that.supportingDocument);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? submittedAt,  String? notes,  SupportingDocumentDto? supportingDocument)?  $default,) {final _that = this;
switch (_that) {
case _MarkSubmittedDeclarationDto() when $default != null:
return $default(_that.submittedAt,_that.notes,_that.supportingDocument);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkSubmittedDeclarationDto implements MarkSubmittedDeclarationDto {
  const _MarkSubmittedDeclarationDto({this.submittedAt, this.notes, this.supportingDocument});
  factory _MarkSubmittedDeclarationDto.fromJson(Map<String, dynamic> json) => _$MarkSubmittedDeclarationDtoFromJson(json);

@override final  String? submittedAt;
@override final  String? notes;
@override final  SupportingDocumentDto? supportingDocument;

/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkSubmittedDeclarationDtoCopyWith<_MarkSubmittedDeclarationDto> get copyWith => __$MarkSubmittedDeclarationDtoCopyWithImpl<_MarkSubmittedDeclarationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkSubmittedDeclarationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkSubmittedDeclarationDto&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.supportingDocument, supportingDocument) || other.supportingDocument == supportingDocument));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submittedAt,notes,supportingDocument);

@override
String toString() {
  return 'MarkSubmittedDeclarationDto(submittedAt: $submittedAt, notes: $notes, supportingDocument: $supportingDocument)';
}


}

/// @nodoc
abstract mixin class _$MarkSubmittedDeclarationDtoCopyWith<$Res> implements $MarkSubmittedDeclarationDtoCopyWith<$Res> {
  factory _$MarkSubmittedDeclarationDtoCopyWith(_MarkSubmittedDeclarationDto value, $Res Function(_MarkSubmittedDeclarationDto) _then) = __$MarkSubmittedDeclarationDtoCopyWithImpl;
@override @useResult
$Res call({
 String? submittedAt, String? notes, SupportingDocumentDto? supportingDocument
});


@override $SupportingDocumentDtoCopyWith<$Res>? get supportingDocument;

}
/// @nodoc
class __$MarkSubmittedDeclarationDtoCopyWithImpl<$Res>
    implements _$MarkSubmittedDeclarationDtoCopyWith<$Res> {
  __$MarkSubmittedDeclarationDtoCopyWithImpl(this._self, this._then);

  final _MarkSubmittedDeclarationDto _self;
  final $Res Function(_MarkSubmittedDeclarationDto) _then;

/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submittedAt = freezed,Object? notes = freezed,Object? supportingDocument = freezed,}) {
  return _then(_MarkSubmittedDeclarationDto(
submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,supportingDocument: freezed == supportingDocument ? _self.supportingDocument : supportingDocument // ignore: cast_nullable_to_non_nullable
as SupportingDocumentDto?,
  ));
}

/// Create a copy of MarkSubmittedDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportingDocumentDtoCopyWith<$Res>? get supportingDocument {
    if (_self.supportingDocument == null) {
    return null;
  }

  return $SupportingDocumentDtoCopyWith<$Res>(_self.supportingDocument!, (value) {
    return _then(_self.copyWith(supportingDocument: value));
  });
}
}


/// @nodoc
mixin _$SupportingDocumentDto {

 String get fileName; String get storageKey; String? get checksum; String? get description; String? get type;
/// Create a copy of SupportingDocumentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportingDocumentDtoCopyWith<SupportingDocumentDto> get copyWith => _$SupportingDocumentDtoCopyWithImpl<SupportingDocumentDto>(this as SupportingDocumentDto, _$identity);

  /// Serializes this SupportingDocumentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportingDocumentDto&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.storageKey, storageKey) || other.storageKey == storageKey)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,storageKey,checksum,description,type);

@override
String toString() {
  return 'SupportingDocumentDto(fileName: $fileName, storageKey: $storageKey, checksum: $checksum, description: $description, type: $type)';
}


}

/// @nodoc
abstract mixin class $SupportingDocumentDtoCopyWith<$Res>  {
  factory $SupportingDocumentDtoCopyWith(SupportingDocumentDto value, $Res Function(SupportingDocumentDto) _then) = _$SupportingDocumentDtoCopyWithImpl;
@useResult
$Res call({
 String fileName, String storageKey, String? checksum, String? description, String? type
});




}
/// @nodoc
class _$SupportingDocumentDtoCopyWithImpl<$Res>
    implements $SupportingDocumentDtoCopyWith<$Res> {
  _$SupportingDocumentDtoCopyWithImpl(this._self, this._then);

  final SupportingDocumentDto _self;
  final $Res Function(SupportingDocumentDto) _then;

/// Create a copy of SupportingDocumentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? storageKey = null,Object? checksum = freezed,Object? description = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,storageKey: null == storageKey ? _self.storageKey : storageKey // ignore: cast_nullable_to_non_nullable
as String,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportingDocumentDto].
extension SupportingDocumentDtoPatterns on SupportingDocumentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportingDocumentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportingDocumentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportingDocumentDto value)  $default,){
final _that = this;
switch (_that) {
case _SupportingDocumentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportingDocumentDto value)?  $default,){
final _that = this;
switch (_that) {
case _SupportingDocumentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  String storageKey,  String? checksum,  String? description,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportingDocumentDto() when $default != null:
return $default(_that.fileName,_that.storageKey,_that.checksum,_that.description,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  String storageKey,  String? checksum,  String? description,  String? type)  $default,) {final _that = this;
switch (_that) {
case _SupportingDocumentDto():
return $default(_that.fileName,_that.storageKey,_that.checksum,_that.description,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  String storageKey,  String? checksum,  String? description,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _SupportingDocumentDto() when $default != null:
return $default(_that.fileName,_that.storageKey,_that.checksum,_that.description,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportingDocumentDto implements SupportingDocumentDto {
  const _SupportingDocumentDto({required this.fileName, required this.storageKey, this.checksum, this.description, this.type});
  factory _SupportingDocumentDto.fromJson(Map<String, dynamic> json) => _$SupportingDocumentDtoFromJson(json);

@override final  String fileName;
@override final  String storageKey;
@override final  String? checksum;
@override final  String? description;
@override final  String? type;

/// Create a copy of SupportingDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportingDocumentDtoCopyWith<_SupportingDocumentDto> get copyWith => __$SupportingDocumentDtoCopyWithImpl<_SupportingDocumentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportingDocumentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportingDocumentDto&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.storageKey, storageKey) || other.storageKey == storageKey)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,storageKey,checksum,description,type);

@override
String toString() {
  return 'SupportingDocumentDto(fileName: $fileName, storageKey: $storageKey, checksum: $checksum, description: $description, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SupportingDocumentDtoCopyWith<$Res> implements $SupportingDocumentDtoCopyWith<$Res> {
  factory _$SupportingDocumentDtoCopyWith(_SupportingDocumentDto value, $Res Function(_SupportingDocumentDto) _then) = __$SupportingDocumentDtoCopyWithImpl;
@override @useResult
$Res call({
 String fileName, String storageKey, String? checksum, String? description, String? type
});




}
/// @nodoc
class __$SupportingDocumentDtoCopyWithImpl<$Res>
    implements _$SupportingDocumentDtoCopyWith<$Res> {
  __$SupportingDocumentDtoCopyWithImpl(this._self, this._then);

  final _SupportingDocumentDto _self;
  final $Res Function(_SupportingDocumentDto) _then;

/// Create a copy of SupportingDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? storageKey = null,Object? checksum = freezed,Object? description = freezed,Object? type = freezed,}) {
  return _then(_SupportingDocumentDto(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,storageKey: null == storageKey ? _self.storageKey : storageKey // ignore: cast_nullable_to_non_nullable
as String,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
