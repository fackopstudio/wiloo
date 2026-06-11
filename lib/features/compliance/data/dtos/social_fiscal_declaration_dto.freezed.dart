// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_fiscal_declaration_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialFiscalDeclarationDto {

 String get id; String get tenantId; String? get companyId; String get declarationPeriodId; String get type; String get status; String? get ruleSetId; Object get totalGrossSalary; Object get totalTaxableBase; Object get totalEmployeeContributions; Object get totalEmployerContributions; Object get totalWithholdings; List<String>? get warnings; Map<String, Object?>? get metadata; String? get validatedBy; String? get validatedAt; String? get exportedAt; String? get submittedManuallyAt; DeclarationPeriodDto? get period; List<DeclarationLineDto>? get lines; List<DeclarationExportDto>? get exports; List<DeclarationAttachmentDto>? get attachments; String get createdAt; String get updatedAt;
/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFiscalDeclarationDtoCopyWith<SocialFiscalDeclarationDto> get copyWith => _$SocialFiscalDeclarationDtoCopyWithImpl<SocialFiscalDeclarationDto>(this as SocialFiscalDeclarationDto, _$identity);

  /// Serializes this SocialFiscalDeclarationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFiscalDeclarationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.ruleSetId, ruleSetId) || other.ruleSetId == ruleSetId)&&const DeepCollectionEquality().equals(other.totalGrossSalary, totalGrossSalary)&&const DeepCollectionEquality().equals(other.totalTaxableBase, totalTaxableBase)&&const DeepCollectionEquality().equals(other.totalEmployeeContributions, totalEmployeeContributions)&&const DeepCollectionEquality().equals(other.totalEmployerContributions, totalEmployerContributions)&&const DeepCollectionEquality().equals(other.totalWithholdings, totalWithholdings)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.validatedBy, validatedBy) || other.validatedBy == validatedBy)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&(identical(other.submittedManuallyAt, submittedManuallyAt) || other.submittedManuallyAt == submittedManuallyAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.lines, lines)&&const DeepCollectionEquality().equals(other.exports, exports)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tenantId,companyId,declarationPeriodId,type,status,ruleSetId,const DeepCollectionEquality().hash(totalGrossSalary),const DeepCollectionEquality().hash(totalTaxableBase),const DeepCollectionEquality().hash(totalEmployeeContributions),const DeepCollectionEquality().hash(totalEmployerContributions),const DeepCollectionEquality().hash(totalWithholdings),const DeepCollectionEquality().hash(warnings),const DeepCollectionEquality().hash(metadata),validatedBy,validatedAt,exportedAt,submittedManuallyAt,period,const DeepCollectionEquality().hash(lines),const DeepCollectionEquality().hash(exports),const DeepCollectionEquality().hash(attachments),createdAt,updatedAt]);

@override
String toString() {
  return 'SocialFiscalDeclarationDto(id: $id, tenantId: $tenantId, companyId: $companyId, declarationPeriodId: $declarationPeriodId, type: $type, status: $status, ruleSetId: $ruleSetId, totalGrossSalary: $totalGrossSalary, totalTaxableBase: $totalTaxableBase, totalEmployeeContributions: $totalEmployeeContributions, totalEmployerContributions: $totalEmployerContributions, totalWithholdings: $totalWithholdings, warnings: $warnings, metadata: $metadata, validatedBy: $validatedBy, validatedAt: $validatedAt, exportedAt: $exportedAt, submittedManuallyAt: $submittedManuallyAt, period: $period, lines: $lines, exports: $exports, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SocialFiscalDeclarationDtoCopyWith<$Res>  {
  factory $SocialFiscalDeclarationDtoCopyWith(SocialFiscalDeclarationDto value, $Res Function(SocialFiscalDeclarationDto) _then) = _$SocialFiscalDeclarationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String tenantId, String? companyId, String declarationPeriodId, String type, String status, String? ruleSetId, Object totalGrossSalary, Object totalTaxableBase, Object totalEmployeeContributions, Object totalEmployerContributions, Object totalWithholdings, List<String>? warnings, Map<String, Object?>? metadata, String? validatedBy, String? validatedAt, String? exportedAt, String? submittedManuallyAt, DeclarationPeriodDto? period, List<DeclarationLineDto>? lines, List<DeclarationExportDto>? exports, List<DeclarationAttachmentDto>? attachments, String createdAt, String updatedAt
});


$DeclarationPeriodDtoCopyWith<$Res>? get period;

}
/// @nodoc
class _$SocialFiscalDeclarationDtoCopyWithImpl<$Res>
    implements $SocialFiscalDeclarationDtoCopyWith<$Res> {
  _$SocialFiscalDeclarationDtoCopyWithImpl(this._self, this._then);

  final SocialFiscalDeclarationDto _self;
  final $Res Function(SocialFiscalDeclarationDto) _then;

/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? companyId = freezed,Object? declarationPeriodId = null,Object? type = null,Object? status = null,Object? ruleSetId = freezed,Object? totalGrossSalary = null,Object? totalTaxableBase = null,Object? totalEmployeeContributions = null,Object? totalEmployerContributions = null,Object? totalWithholdings = null,Object? warnings = freezed,Object? metadata = freezed,Object? validatedBy = freezed,Object? validatedAt = freezed,Object? exportedAt = freezed,Object? submittedManuallyAt = freezed,Object? period = freezed,Object? lines = freezed,Object? exports = freezed,Object? attachments = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,declarationPeriodId: null == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ruleSetId: freezed == ruleSetId ? _self.ruleSetId : ruleSetId // ignore: cast_nullable_to_non_nullable
as String?,totalGrossSalary: null == totalGrossSalary ? _self.totalGrossSalary : totalGrossSalary ,totalTaxableBase: null == totalTaxableBase ? _self.totalTaxableBase : totalTaxableBase ,totalEmployeeContributions: null == totalEmployeeContributions ? _self.totalEmployeeContributions : totalEmployeeContributions ,totalEmployerContributions: null == totalEmployerContributions ? _self.totalEmployerContributions : totalEmployerContributions ,totalWithholdings: null == totalWithholdings ? _self.totalWithholdings : totalWithholdings ,warnings: freezed == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,validatedBy: freezed == validatedBy ? _self.validatedBy : validatedBy // ignore: cast_nullable_to_non_nullable
as String?,validatedAt: freezed == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as String?,exportedAt: freezed == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as String?,submittedManuallyAt: freezed == submittedManuallyAt ? _self.submittedManuallyAt : submittedManuallyAt // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as DeclarationPeriodDto?,lines: freezed == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<DeclarationLineDto>?,exports: freezed == exports ? _self.exports : exports // ignore: cast_nullable_to_non_nullable
as List<DeclarationExportDto>?,attachments: freezed == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<DeclarationAttachmentDto>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeclarationPeriodDtoCopyWith<$Res>? get period {
    if (_self.period == null) {
    return null;
  }

  return $DeclarationPeriodDtoCopyWith<$Res>(_self.period!, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialFiscalDeclarationDto].
extension SocialFiscalDeclarationDtoPatterns on SocialFiscalDeclarationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFiscalDeclarationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFiscalDeclarationDto value)  $default,){
final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFiscalDeclarationDto value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tenantId,  String? companyId,  String declarationPeriodId,  String type,  String status,  String? ruleSetId,  Object totalGrossSalary,  Object totalTaxableBase,  Object totalEmployeeContributions,  Object totalEmployerContributions,  Object totalWithholdings,  List<String>? warnings,  Map<String, Object?>? metadata,  String? validatedBy,  String? validatedAt,  String? exportedAt,  String? submittedManuallyAt,  DeclarationPeriodDto? period,  List<DeclarationLineDto>? lines,  List<DeclarationExportDto>? exports,  List<DeclarationAttachmentDto>? attachments,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto() when $default != null:
return $default(_that.id,_that.tenantId,_that.companyId,_that.declarationPeriodId,_that.type,_that.status,_that.ruleSetId,_that.totalGrossSalary,_that.totalTaxableBase,_that.totalEmployeeContributions,_that.totalEmployerContributions,_that.totalWithholdings,_that.warnings,_that.metadata,_that.validatedBy,_that.validatedAt,_that.exportedAt,_that.submittedManuallyAt,_that.period,_that.lines,_that.exports,_that.attachments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tenantId,  String? companyId,  String declarationPeriodId,  String type,  String status,  String? ruleSetId,  Object totalGrossSalary,  Object totalTaxableBase,  Object totalEmployeeContributions,  Object totalEmployerContributions,  Object totalWithholdings,  List<String>? warnings,  Map<String, Object?>? metadata,  String? validatedBy,  String? validatedAt,  String? exportedAt,  String? submittedManuallyAt,  DeclarationPeriodDto? period,  List<DeclarationLineDto>? lines,  List<DeclarationExportDto>? exports,  List<DeclarationAttachmentDto>? attachments,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto():
return $default(_that.id,_that.tenantId,_that.companyId,_that.declarationPeriodId,_that.type,_that.status,_that.ruleSetId,_that.totalGrossSalary,_that.totalTaxableBase,_that.totalEmployeeContributions,_that.totalEmployerContributions,_that.totalWithholdings,_that.warnings,_that.metadata,_that.validatedBy,_that.validatedAt,_that.exportedAt,_that.submittedManuallyAt,_that.period,_that.lines,_that.exports,_that.attachments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tenantId,  String? companyId,  String declarationPeriodId,  String type,  String status,  String? ruleSetId,  Object totalGrossSalary,  Object totalTaxableBase,  Object totalEmployeeContributions,  Object totalEmployerContributions,  Object totalWithholdings,  List<String>? warnings,  Map<String, Object?>? metadata,  String? validatedBy,  String? validatedAt,  String? exportedAt,  String? submittedManuallyAt,  DeclarationPeriodDto? period,  List<DeclarationLineDto>? lines,  List<DeclarationExportDto>? exports,  List<DeclarationAttachmentDto>? attachments,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SocialFiscalDeclarationDto() when $default != null:
return $default(_that.id,_that.tenantId,_that.companyId,_that.declarationPeriodId,_that.type,_that.status,_that.ruleSetId,_that.totalGrossSalary,_that.totalTaxableBase,_that.totalEmployeeContributions,_that.totalEmployerContributions,_that.totalWithholdings,_that.warnings,_that.metadata,_that.validatedBy,_that.validatedAt,_that.exportedAt,_that.submittedManuallyAt,_that.period,_that.lines,_that.exports,_that.attachments,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFiscalDeclarationDto implements SocialFiscalDeclarationDto {
  const _SocialFiscalDeclarationDto({required this.id, required this.tenantId, this.companyId, required this.declarationPeriodId, required this.type, required this.status, this.ruleSetId, required this.totalGrossSalary, required this.totalTaxableBase, required this.totalEmployeeContributions, required this.totalEmployerContributions, required this.totalWithholdings, final  List<String>? warnings, final  Map<String, Object?>? metadata, this.validatedBy, this.validatedAt, this.exportedAt, this.submittedManuallyAt, this.period, final  List<DeclarationLineDto>? lines, final  List<DeclarationExportDto>? exports, final  List<DeclarationAttachmentDto>? attachments, required this.createdAt, required this.updatedAt}): _warnings = warnings,_metadata = metadata,_lines = lines,_exports = exports,_attachments = attachments;
  factory _SocialFiscalDeclarationDto.fromJson(Map<String, dynamic> json) => _$SocialFiscalDeclarationDtoFromJson(json);

@override final  String id;
@override final  String tenantId;
@override final  String? companyId;
@override final  String declarationPeriodId;
@override final  String type;
@override final  String status;
@override final  String? ruleSetId;
@override final  Object totalGrossSalary;
@override final  Object totalTaxableBase;
@override final  Object totalEmployeeContributions;
@override final  Object totalEmployerContributions;
@override final  Object totalWithholdings;
 final  List<String>? _warnings;
@override List<String>? get warnings {
  final value = _warnings;
  if (value == null) return null;
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, Object?>? _metadata;
@override Map<String, Object?>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? validatedBy;
@override final  String? validatedAt;
@override final  String? exportedAt;
@override final  String? submittedManuallyAt;
@override final  DeclarationPeriodDto? period;
 final  List<DeclarationLineDto>? _lines;
@override List<DeclarationLineDto>? get lines {
  final value = _lines;
  if (value == null) return null;
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DeclarationExportDto>? _exports;
@override List<DeclarationExportDto>? get exports {
  final value = _exports;
  if (value == null) return null;
  if (_exports is EqualUnmodifiableListView) return _exports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<DeclarationAttachmentDto>? _attachments;
@override List<DeclarationAttachmentDto>? get attachments {
  final value = _attachments;
  if (value == null) return null;
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFiscalDeclarationDtoCopyWith<_SocialFiscalDeclarationDto> get copyWith => __$SocialFiscalDeclarationDtoCopyWithImpl<_SocialFiscalDeclarationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFiscalDeclarationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFiscalDeclarationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.declarationPeriodId, declarationPeriodId) || other.declarationPeriodId == declarationPeriodId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.ruleSetId, ruleSetId) || other.ruleSetId == ruleSetId)&&const DeepCollectionEquality().equals(other.totalGrossSalary, totalGrossSalary)&&const DeepCollectionEquality().equals(other.totalTaxableBase, totalTaxableBase)&&const DeepCollectionEquality().equals(other.totalEmployeeContributions, totalEmployeeContributions)&&const DeepCollectionEquality().equals(other.totalEmployerContributions, totalEmployerContributions)&&const DeepCollectionEquality().equals(other.totalWithholdings, totalWithholdings)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.validatedBy, validatedBy) || other.validatedBy == validatedBy)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&(identical(other.submittedManuallyAt, submittedManuallyAt) || other.submittedManuallyAt == submittedManuallyAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._lines, _lines)&&const DeepCollectionEquality().equals(other._exports, _exports)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tenantId,companyId,declarationPeriodId,type,status,ruleSetId,const DeepCollectionEquality().hash(totalGrossSalary),const DeepCollectionEquality().hash(totalTaxableBase),const DeepCollectionEquality().hash(totalEmployeeContributions),const DeepCollectionEquality().hash(totalEmployerContributions),const DeepCollectionEquality().hash(totalWithholdings),const DeepCollectionEquality().hash(_warnings),const DeepCollectionEquality().hash(_metadata),validatedBy,validatedAt,exportedAt,submittedManuallyAt,period,const DeepCollectionEquality().hash(_lines),const DeepCollectionEquality().hash(_exports),const DeepCollectionEquality().hash(_attachments),createdAt,updatedAt]);

@override
String toString() {
  return 'SocialFiscalDeclarationDto(id: $id, tenantId: $tenantId, companyId: $companyId, declarationPeriodId: $declarationPeriodId, type: $type, status: $status, ruleSetId: $ruleSetId, totalGrossSalary: $totalGrossSalary, totalTaxableBase: $totalTaxableBase, totalEmployeeContributions: $totalEmployeeContributions, totalEmployerContributions: $totalEmployerContributions, totalWithholdings: $totalWithholdings, warnings: $warnings, metadata: $metadata, validatedBy: $validatedBy, validatedAt: $validatedAt, exportedAt: $exportedAt, submittedManuallyAt: $submittedManuallyAt, period: $period, lines: $lines, exports: $exports, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SocialFiscalDeclarationDtoCopyWith<$Res> implements $SocialFiscalDeclarationDtoCopyWith<$Res> {
  factory _$SocialFiscalDeclarationDtoCopyWith(_SocialFiscalDeclarationDto value, $Res Function(_SocialFiscalDeclarationDto) _then) = __$SocialFiscalDeclarationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String tenantId, String? companyId, String declarationPeriodId, String type, String status, String? ruleSetId, Object totalGrossSalary, Object totalTaxableBase, Object totalEmployeeContributions, Object totalEmployerContributions, Object totalWithholdings, List<String>? warnings, Map<String, Object?>? metadata, String? validatedBy, String? validatedAt, String? exportedAt, String? submittedManuallyAt, DeclarationPeriodDto? period, List<DeclarationLineDto>? lines, List<DeclarationExportDto>? exports, List<DeclarationAttachmentDto>? attachments, String createdAt, String updatedAt
});


@override $DeclarationPeriodDtoCopyWith<$Res>? get period;

}
/// @nodoc
class __$SocialFiscalDeclarationDtoCopyWithImpl<$Res>
    implements _$SocialFiscalDeclarationDtoCopyWith<$Res> {
  __$SocialFiscalDeclarationDtoCopyWithImpl(this._self, this._then);

  final _SocialFiscalDeclarationDto _self;
  final $Res Function(_SocialFiscalDeclarationDto) _then;

/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? companyId = freezed,Object? declarationPeriodId = null,Object? type = null,Object? status = null,Object? ruleSetId = freezed,Object? totalGrossSalary = null,Object? totalTaxableBase = null,Object? totalEmployeeContributions = null,Object? totalEmployerContributions = null,Object? totalWithholdings = null,Object? warnings = freezed,Object? metadata = freezed,Object? validatedBy = freezed,Object? validatedAt = freezed,Object? exportedAt = freezed,Object? submittedManuallyAt = freezed,Object? period = freezed,Object? lines = freezed,Object? exports = freezed,Object? attachments = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SocialFiscalDeclarationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,declarationPeriodId: null == declarationPeriodId ? _self.declarationPeriodId : declarationPeriodId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ruleSetId: freezed == ruleSetId ? _self.ruleSetId : ruleSetId // ignore: cast_nullable_to_non_nullable
as String?,totalGrossSalary: null == totalGrossSalary ? _self.totalGrossSalary : totalGrossSalary ,totalTaxableBase: null == totalTaxableBase ? _self.totalTaxableBase : totalTaxableBase ,totalEmployeeContributions: null == totalEmployeeContributions ? _self.totalEmployeeContributions : totalEmployeeContributions ,totalEmployerContributions: null == totalEmployerContributions ? _self.totalEmployerContributions : totalEmployerContributions ,totalWithholdings: null == totalWithholdings ? _self.totalWithholdings : totalWithholdings ,warnings: freezed == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,validatedBy: freezed == validatedBy ? _self.validatedBy : validatedBy // ignore: cast_nullable_to_non_nullable
as String?,validatedAt: freezed == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as String?,exportedAt: freezed == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as String?,submittedManuallyAt: freezed == submittedManuallyAt ? _self.submittedManuallyAt : submittedManuallyAt // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as DeclarationPeriodDto?,lines: freezed == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<DeclarationLineDto>?,exports: freezed == exports ? _self._exports : exports // ignore: cast_nullable_to_non_nullable
as List<DeclarationExportDto>?,attachments: freezed == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<DeclarationAttachmentDto>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SocialFiscalDeclarationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeclarationPeriodDtoCopyWith<$Res>? get period {
    if (_self.period == null) {
    return null;
  }

  return $DeclarationPeriodDtoCopyWith<$Res>(_self.period!, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}

// dart format on
