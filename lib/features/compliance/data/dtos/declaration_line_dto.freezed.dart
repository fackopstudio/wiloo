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

 String? get id; String? get declarationId; String? get employeeId; String? get payrollId; String? get userId; Map<String, Object?>? get employeeSnapshot; Map<String, Object?>? get contractSnapshot; Map<String, Object?>? get companySnapshot; Object? get grossSalary; Object? get taxableSalary; Object? get socialContributionBase; Object? get employeeContributionAmount; Object? get employerContributionAmount; Object? get withholdingAmount; Map<String, Object?>? get deductionsSnapshot; Map<String, Object?>? get benefitsInKindSnapshot; Map<String, Object?>? get calculationDetails; List<String>? get warnings; String? get createdAt; String? get updatedAt; Map<String, Object?> get raw;
/// Create a copy of DeclarationLineDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeclarationLineDtoCopyWith<DeclarationLineDto> get copyWith => _$DeclarationLineDtoCopyWithImpl<DeclarationLineDto>(this as DeclarationLineDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeclarationLineDto&&(identical(other.id, id) || other.id == id)&&(identical(other.declarationId, declarationId) || other.declarationId == declarationId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.payrollId, payrollId) || other.payrollId == payrollId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.employeeSnapshot, employeeSnapshot)&&const DeepCollectionEquality().equals(other.contractSnapshot, contractSnapshot)&&const DeepCollectionEquality().equals(other.companySnapshot, companySnapshot)&&const DeepCollectionEquality().equals(other.grossSalary, grossSalary)&&const DeepCollectionEquality().equals(other.taxableSalary, taxableSalary)&&const DeepCollectionEquality().equals(other.socialContributionBase, socialContributionBase)&&const DeepCollectionEquality().equals(other.employeeContributionAmount, employeeContributionAmount)&&const DeepCollectionEquality().equals(other.employerContributionAmount, employerContributionAmount)&&const DeepCollectionEquality().equals(other.withholdingAmount, withholdingAmount)&&const DeepCollectionEquality().equals(other.deductionsSnapshot, deductionsSnapshot)&&const DeepCollectionEquality().equals(other.benefitsInKindSnapshot, benefitsInKindSnapshot)&&const DeepCollectionEquality().equals(other.calculationDetails, calculationDetails)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.raw, raw));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,declarationId,employeeId,payrollId,userId,const DeepCollectionEquality().hash(employeeSnapshot),const DeepCollectionEquality().hash(contractSnapshot),const DeepCollectionEquality().hash(companySnapshot),const DeepCollectionEquality().hash(grossSalary),const DeepCollectionEquality().hash(taxableSalary),const DeepCollectionEquality().hash(socialContributionBase),const DeepCollectionEquality().hash(employeeContributionAmount),const DeepCollectionEquality().hash(employerContributionAmount),const DeepCollectionEquality().hash(withholdingAmount),const DeepCollectionEquality().hash(deductionsSnapshot),const DeepCollectionEquality().hash(benefitsInKindSnapshot),const DeepCollectionEquality().hash(calculationDetails),const DeepCollectionEquality().hash(warnings),createdAt,updatedAt,const DeepCollectionEquality().hash(raw)]);

@override
String toString() {
  return 'DeclarationLineDto(id: $id, declarationId: $declarationId, employeeId: $employeeId, payrollId: $payrollId, userId: $userId, employeeSnapshot: $employeeSnapshot, contractSnapshot: $contractSnapshot, companySnapshot: $companySnapshot, grossSalary: $grossSalary, taxableSalary: $taxableSalary, socialContributionBase: $socialContributionBase, employeeContributionAmount: $employeeContributionAmount, employerContributionAmount: $employerContributionAmount, withholdingAmount: $withholdingAmount, deductionsSnapshot: $deductionsSnapshot, benefitsInKindSnapshot: $benefitsInKindSnapshot, calculationDetails: $calculationDetails, warnings: $warnings, createdAt: $createdAt, updatedAt: $updatedAt, raw: $raw)';
}


}

/// @nodoc
abstract mixin class $DeclarationLineDtoCopyWith<$Res>  {
  factory $DeclarationLineDtoCopyWith(DeclarationLineDto value, $Res Function(DeclarationLineDto) _then) = _$DeclarationLineDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String? declarationId, String? employeeId, String? payrollId, String? userId, Map<String, Object?>? employeeSnapshot, Map<String, Object?>? contractSnapshot, Map<String, Object?>? companySnapshot, Object? grossSalary, Object? taxableSalary, Object? socialContributionBase, Object? employeeContributionAmount, Object? employerContributionAmount, Object? withholdingAmount, Map<String, Object?>? deductionsSnapshot, Map<String, Object?>? benefitsInKindSnapshot, Map<String, Object?>? calculationDetails, List<String>? warnings, String? createdAt, String? updatedAt, Map<String, Object?> raw
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? declarationId = freezed,Object? employeeId = freezed,Object? payrollId = freezed,Object? userId = freezed,Object? employeeSnapshot = freezed,Object? contractSnapshot = freezed,Object? companySnapshot = freezed,Object? grossSalary = freezed,Object? taxableSalary = freezed,Object? socialContributionBase = freezed,Object? employeeContributionAmount = freezed,Object? employerContributionAmount = freezed,Object? withholdingAmount = freezed,Object? deductionsSnapshot = freezed,Object? benefitsInKindSnapshot = freezed,Object? calculationDetails = freezed,Object? warnings = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? raw = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,declarationId: freezed == declarationId ? _self.declarationId : declarationId // ignore: cast_nullable_to_non_nullable
as String?,employeeId: freezed == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String?,payrollId: freezed == payrollId ? _self.payrollId : payrollId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,employeeSnapshot: freezed == employeeSnapshot ? _self.employeeSnapshot : employeeSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,contractSnapshot: freezed == contractSnapshot ? _self.contractSnapshot : contractSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,companySnapshot: freezed == companySnapshot ? _self.companySnapshot : companySnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,grossSalary: freezed == grossSalary ? _self.grossSalary : grossSalary ,taxableSalary: freezed == taxableSalary ? _self.taxableSalary : taxableSalary ,socialContributionBase: freezed == socialContributionBase ? _self.socialContributionBase : socialContributionBase ,employeeContributionAmount: freezed == employeeContributionAmount ? _self.employeeContributionAmount : employeeContributionAmount ,employerContributionAmount: freezed == employerContributionAmount ? _self.employerContributionAmount : employerContributionAmount ,withholdingAmount: freezed == withholdingAmount ? _self.withholdingAmount : withholdingAmount ,deductionsSnapshot: freezed == deductionsSnapshot ? _self.deductionsSnapshot : deductionsSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,benefitsInKindSnapshot: freezed == benefitsInKindSnapshot ? _self.benefitsInKindSnapshot : benefitsInKindSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,calculationDetails: freezed == calculationDetails ? _self.calculationDetails : calculationDetails // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,warnings: freezed == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? declarationId,  String? employeeId,  String? payrollId,  String? userId,  Map<String, Object?>? employeeSnapshot,  Map<String, Object?>? contractSnapshot,  Map<String, Object?>? companySnapshot,  Object? grossSalary,  Object? taxableSalary,  Object? socialContributionBase,  Object? employeeContributionAmount,  Object? employerContributionAmount,  Object? withholdingAmount,  Map<String, Object?>? deductionsSnapshot,  Map<String, Object?>? benefitsInKindSnapshot,  Map<String, Object?>? calculationDetails,  List<String>? warnings,  String? createdAt,  String? updatedAt,  Map<String, Object?> raw)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
return $default(_that.id,_that.declarationId,_that.employeeId,_that.payrollId,_that.userId,_that.employeeSnapshot,_that.contractSnapshot,_that.companySnapshot,_that.grossSalary,_that.taxableSalary,_that.socialContributionBase,_that.employeeContributionAmount,_that.employerContributionAmount,_that.withholdingAmount,_that.deductionsSnapshot,_that.benefitsInKindSnapshot,_that.calculationDetails,_that.warnings,_that.createdAt,_that.updatedAt,_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? declarationId,  String? employeeId,  String? payrollId,  String? userId,  Map<String, Object?>? employeeSnapshot,  Map<String, Object?>? contractSnapshot,  Map<String, Object?>? companySnapshot,  Object? grossSalary,  Object? taxableSalary,  Object? socialContributionBase,  Object? employeeContributionAmount,  Object? employerContributionAmount,  Object? withholdingAmount,  Map<String, Object?>? deductionsSnapshot,  Map<String, Object?>? benefitsInKindSnapshot,  Map<String, Object?>? calculationDetails,  List<String>? warnings,  String? createdAt,  String? updatedAt,  Map<String, Object?> raw)  $default,) {final _that = this;
switch (_that) {
case _DeclarationLineDto():
return $default(_that.id,_that.declarationId,_that.employeeId,_that.payrollId,_that.userId,_that.employeeSnapshot,_that.contractSnapshot,_that.companySnapshot,_that.grossSalary,_that.taxableSalary,_that.socialContributionBase,_that.employeeContributionAmount,_that.employerContributionAmount,_that.withholdingAmount,_that.deductionsSnapshot,_that.benefitsInKindSnapshot,_that.calculationDetails,_that.warnings,_that.createdAt,_that.updatedAt,_that.raw);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? declarationId,  String? employeeId,  String? payrollId,  String? userId,  Map<String, Object?>? employeeSnapshot,  Map<String, Object?>? contractSnapshot,  Map<String, Object?>? companySnapshot,  Object? grossSalary,  Object? taxableSalary,  Object? socialContributionBase,  Object? employeeContributionAmount,  Object? employerContributionAmount,  Object? withholdingAmount,  Map<String, Object?>? deductionsSnapshot,  Map<String, Object?>? benefitsInKindSnapshot,  Map<String, Object?>? calculationDetails,  List<String>? warnings,  String? createdAt,  String? updatedAt,  Map<String, Object?> raw)?  $default,) {final _that = this;
switch (_that) {
case _DeclarationLineDto() when $default != null:
return $default(_that.id,_that.declarationId,_that.employeeId,_that.payrollId,_that.userId,_that.employeeSnapshot,_that.contractSnapshot,_that.companySnapshot,_that.grossSalary,_that.taxableSalary,_that.socialContributionBase,_that.employeeContributionAmount,_that.employerContributionAmount,_that.withholdingAmount,_that.deductionsSnapshot,_that.benefitsInKindSnapshot,_that.calculationDetails,_that.warnings,_that.createdAt,_that.updatedAt,_that.raw);case _:
  return null;

}
}

}

/// @nodoc


class _DeclarationLineDto extends DeclarationLineDto {
  const _DeclarationLineDto({this.id, this.declarationId, this.employeeId, this.payrollId, this.userId, final  Map<String, Object?>? employeeSnapshot, final  Map<String, Object?>? contractSnapshot, final  Map<String, Object?>? companySnapshot, this.grossSalary, this.taxableSalary, this.socialContributionBase, this.employeeContributionAmount, this.employerContributionAmount, this.withholdingAmount, final  Map<String, Object?>? deductionsSnapshot, final  Map<String, Object?>? benefitsInKindSnapshot, final  Map<String, Object?>? calculationDetails, final  List<String>? warnings, this.createdAt, this.updatedAt, final  Map<String, Object?> raw = const <String, Object?>{}}): _employeeSnapshot = employeeSnapshot,_contractSnapshot = contractSnapshot,_companySnapshot = companySnapshot,_deductionsSnapshot = deductionsSnapshot,_benefitsInKindSnapshot = benefitsInKindSnapshot,_calculationDetails = calculationDetails,_warnings = warnings,_raw = raw,super._();
  

@override final  String? id;
@override final  String? declarationId;
@override final  String? employeeId;
@override final  String? payrollId;
@override final  String? userId;
 final  Map<String, Object?>? _employeeSnapshot;
@override Map<String, Object?>? get employeeSnapshot {
  final value = _employeeSnapshot;
  if (value == null) return null;
  if (_employeeSnapshot is EqualUnmodifiableMapView) return _employeeSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Object?>? _contractSnapshot;
@override Map<String, Object?>? get contractSnapshot {
  final value = _contractSnapshot;
  if (value == null) return null;
  if (_contractSnapshot is EqualUnmodifiableMapView) return _contractSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Object?>? _companySnapshot;
@override Map<String, Object?>? get companySnapshot {
  final value = _companySnapshot;
  if (value == null) return null;
  if (_companySnapshot is EqualUnmodifiableMapView) return _companySnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  Object? grossSalary;
@override final  Object? taxableSalary;
@override final  Object? socialContributionBase;
@override final  Object? employeeContributionAmount;
@override final  Object? employerContributionAmount;
@override final  Object? withholdingAmount;
 final  Map<String, Object?>? _deductionsSnapshot;
@override Map<String, Object?>? get deductionsSnapshot {
  final value = _deductionsSnapshot;
  if (value == null) return null;
  if (_deductionsSnapshot is EqualUnmodifiableMapView) return _deductionsSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Object?>? _benefitsInKindSnapshot;
@override Map<String, Object?>? get benefitsInKindSnapshot {
  final value = _benefitsInKindSnapshot;
  if (value == null) return null;
  if (_benefitsInKindSnapshot is EqualUnmodifiableMapView) return _benefitsInKindSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Object?>? _calculationDetails;
@override Map<String, Object?>? get calculationDetails {
  final value = _calculationDetails;
  if (value == null) return null;
  if (_calculationDetails is EqualUnmodifiableMapView) return _calculationDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String>? _warnings;
@override List<String>? get warnings {
  final value = _warnings;
  if (value == null) return null;
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? createdAt;
@override final  String? updatedAt;
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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclarationLineDto&&(identical(other.id, id) || other.id == id)&&(identical(other.declarationId, declarationId) || other.declarationId == declarationId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.payrollId, payrollId) || other.payrollId == payrollId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._employeeSnapshot, _employeeSnapshot)&&const DeepCollectionEquality().equals(other._contractSnapshot, _contractSnapshot)&&const DeepCollectionEquality().equals(other._companySnapshot, _companySnapshot)&&const DeepCollectionEquality().equals(other.grossSalary, grossSalary)&&const DeepCollectionEquality().equals(other.taxableSalary, taxableSalary)&&const DeepCollectionEquality().equals(other.socialContributionBase, socialContributionBase)&&const DeepCollectionEquality().equals(other.employeeContributionAmount, employeeContributionAmount)&&const DeepCollectionEquality().equals(other.employerContributionAmount, employerContributionAmount)&&const DeepCollectionEquality().equals(other.withholdingAmount, withholdingAmount)&&const DeepCollectionEquality().equals(other._deductionsSnapshot, _deductionsSnapshot)&&const DeepCollectionEquality().equals(other._benefitsInKindSnapshot, _benefitsInKindSnapshot)&&const DeepCollectionEquality().equals(other._calculationDetails, _calculationDetails)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._raw, _raw));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,declarationId,employeeId,payrollId,userId,const DeepCollectionEquality().hash(_employeeSnapshot),const DeepCollectionEquality().hash(_contractSnapshot),const DeepCollectionEquality().hash(_companySnapshot),const DeepCollectionEquality().hash(grossSalary),const DeepCollectionEquality().hash(taxableSalary),const DeepCollectionEquality().hash(socialContributionBase),const DeepCollectionEquality().hash(employeeContributionAmount),const DeepCollectionEquality().hash(employerContributionAmount),const DeepCollectionEquality().hash(withholdingAmount),const DeepCollectionEquality().hash(_deductionsSnapshot),const DeepCollectionEquality().hash(_benefitsInKindSnapshot),const DeepCollectionEquality().hash(_calculationDetails),const DeepCollectionEquality().hash(_warnings),createdAt,updatedAt,const DeepCollectionEquality().hash(_raw)]);

@override
String toString() {
  return 'DeclarationLineDto(id: $id, declarationId: $declarationId, employeeId: $employeeId, payrollId: $payrollId, userId: $userId, employeeSnapshot: $employeeSnapshot, contractSnapshot: $contractSnapshot, companySnapshot: $companySnapshot, grossSalary: $grossSalary, taxableSalary: $taxableSalary, socialContributionBase: $socialContributionBase, employeeContributionAmount: $employeeContributionAmount, employerContributionAmount: $employerContributionAmount, withholdingAmount: $withholdingAmount, deductionsSnapshot: $deductionsSnapshot, benefitsInKindSnapshot: $benefitsInKindSnapshot, calculationDetails: $calculationDetails, warnings: $warnings, createdAt: $createdAt, updatedAt: $updatedAt, raw: $raw)';
}


}

/// @nodoc
abstract mixin class _$DeclarationLineDtoCopyWith<$Res> implements $DeclarationLineDtoCopyWith<$Res> {
  factory _$DeclarationLineDtoCopyWith(_DeclarationLineDto value, $Res Function(_DeclarationLineDto) _then) = __$DeclarationLineDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? declarationId, String? employeeId, String? payrollId, String? userId, Map<String, Object?>? employeeSnapshot, Map<String, Object?>? contractSnapshot, Map<String, Object?>? companySnapshot, Object? grossSalary, Object? taxableSalary, Object? socialContributionBase, Object? employeeContributionAmount, Object? employerContributionAmount, Object? withholdingAmount, Map<String, Object?>? deductionsSnapshot, Map<String, Object?>? benefitsInKindSnapshot, Map<String, Object?>? calculationDetails, List<String>? warnings, String? createdAt, String? updatedAt, Map<String, Object?> raw
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? declarationId = freezed,Object? employeeId = freezed,Object? payrollId = freezed,Object? userId = freezed,Object? employeeSnapshot = freezed,Object? contractSnapshot = freezed,Object? companySnapshot = freezed,Object? grossSalary = freezed,Object? taxableSalary = freezed,Object? socialContributionBase = freezed,Object? employeeContributionAmount = freezed,Object? employerContributionAmount = freezed,Object? withholdingAmount = freezed,Object? deductionsSnapshot = freezed,Object? benefitsInKindSnapshot = freezed,Object? calculationDetails = freezed,Object? warnings = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? raw = null,}) {
  return _then(_DeclarationLineDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,declarationId: freezed == declarationId ? _self.declarationId : declarationId // ignore: cast_nullable_to_non_nullable
as String?,employeeId: freezed == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String?,payrollId: freezed == payrollId ? _self.payrollId : payrollId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,employeeSnapshot: freezed == employeeSnapshot ? _self._employeeSnapshot : employeeSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,contractSnapshot: freezed == contractSnapshot ? _self._contractSnapshot : contractSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,companySnapshot: freezed == companySnapshot ? _self._companySnapshot : companySnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,grossSalary: freezed == grossSalary ? _self.grossSalary : grossSalary ,taxableSalary: freezed == taxableSalary ? _self.taxableSalary : taxableSalary ,socialContributionBase: freezed == socialContributionBase ? _self.socialContributionBase : socialContributionBase ,employeeContributionAmount: freezed == employeeContributionAmount ? _self.employeeContributionAmount : employeeContributionAmount ,employerContributionAmount: freezed == employerContributionAmount ? _self.employerContributionAmount : employerContributionAmount ,withholdingAmount: freezed == withholdingAmount ? _self.withholdingAmount : withholdingAmount ,deductionsSnapshot: freezed == deductionsSnapshot ? _self._deductionsSnapshot : deductionsSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,benefitsInKindSnapshot: freezed == benefitsInKindSnapshot ? _self._benefitsInKindSnapshot : benefitsInKindSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,calculationDetails: freezed == calculationDetails ? _self._calculationDetails : calculationDetails // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,warnings: freezed == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
