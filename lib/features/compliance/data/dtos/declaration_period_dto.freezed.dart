// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'declaration_period_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeclarationPeriodDto {

 String get id; String get tenantId; String? get companyId; String get periodType; int get year; int? get month; int? get quarter; String get startDate; String get endDate; int? get payrollMonth; int? get payrollYear; String get status; Map<String, Object?>? get metadata; String get createdAt; String get updatedAt;
/// Create a copy of DeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeclarationPeriodDtoCopyWith<DeclarationPeriodDto> get copyWith => _$DeclarationPeriodDtoCopyWithImpl<DeclarationPeriodDto>(this as DeclarationPeriodDto, _$identity);

  /// Serializes this DeclarationPeriodDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeclarationPeriodDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,companyId,periodType,year,month,quarter,startDate,endDate,payrollMonth,payrollYear,status,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt);

@override
String toString() {
  return 'DeclarationPeriodDto(id: $id, tenantId: $tenantId, companyId: $companyId, periodType: $periodType, year: $year, month: $month, quarter: $quarter, startDate: $startDate, endDate: $endDate, payrollMonth: $payrollMonth, payrollYear: $payrollYear, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DeclarationPeriodDtoCopyWith<$Res>  {
  factory $DeclarationPeriodDtoCopyWith(DeclarationPeriodDto value, $Res Function(DeclarationPeriodDto) _then) = _$DeclarationPeriodDtoCopyWithImpl;
@useResult
$Res call({
 String id, String tenantId, String? companyId, String periodType, int year, int? month, int? quarter, String startDate, String endDate, int? payrollMonth, int? payrollYear, String status, Map<String, Object?>? metadata, String createdAt, String updatedAt
});




}
/// @nodoc
class _$DeclarationPeriodDtoCopyWithImpl<$Res>
    implements $DeclarationPeriodDtoCopyWith<$Res> {
  _$DeclarationPeriodDtoCopyWithImpl(this._self, this._then);

  final DeclarationPeriodDto _self;
  final $Res Function(DeclarationPeriodDto) _then;

/// Create a copy of DeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? companyId = freezed,Object? periodType = null,Object? year = null,Object? month = freezed,Object? quarter = freezed,Object? startDate = null,Object? endDate = null,Object? payrollMonth = freezed,Object? payrollYear = freezed,Object? status = null,Object? metadata = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeclarationPeriodDto].
extension DeclarationPeriodDtoPatterns on DeclarationPeriodDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeclarationPeriodDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeclarationPeriodDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeclarationPeriodDto value)  $default,){
final _that = this;
switch (_that) {
case _DeclarationPeriodDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeclarationPeriodDto value)?  $default,){
final _that = this;
switch (_that) {
case _DeclarationPeriodDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tenantId,  String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  String status,  Map<String, Object?>? metadata,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeclarationPeriodDto() when $default != null:
return $default(_that.id,_that.tenantId,_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.status,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tenantId,  String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  String status,  Map<String, Object?>? metadata,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DeclarationPeriodDto():
return $default(_that.id,_that.tenantId,_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.status,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tenantId,  String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  String status,  Map<String, Object?>? metadata,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeclarationPeriodDto() when $default != null:
return $default(_that.id,_that.tenantId,_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.status,_that.metadata,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeclarationPeriodDto implements DeclarationPeriodDto {
  const _DeclarationPeriodDto({required this.id, required this.tenantId, this.companyId, required this.periodType, required this.year, this.month, this.quarter, required this.startDate, required this.endDate, this.payrollMonth, this.payrollYear, required this.status, final  Map<String, Object?>? metadata, required this.createdAt, required this.updatedAt}): _metadata = metadata;
  factory _DeclarationPeriodDto.fromJson(Map<String, dynamic> json) => _$DeclarationPeriodDtoFromJson(json);

@override final  String id;
@override final  String tenantId;
@override final  String? companyId;
@override final  String periodType;
@override final  int year;
@override final  int? month;
@override final  int? quarter;
@override final  String startDate;
@override final  String endDate;
@override final  int? payrollMonth;
@override final  int? payrollYear;
@override final  String status;
 final  Map<String, Object?>? _metadata;
@override Map<String, Object?>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of DeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclarationPeriodDtoCopyWith<_DeclarationPeriodDto> get copyWith => __$DeclarationPeriodDtoCopyWithImpl<_DeclarationPeriodDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeclarationPeriodDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclarationPeriodDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,companyId,periodType,year,month,quarter,startDate,endDate,payrollMonth,payrollYear,status,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt);

@override
String toString() {
  return 'DeclarationPeriodDto(id: $id, tenantId: $tenantId, companyId: $companyId, periodType: $periodType, year: $year, month: $month, quarter: $quarter, startDate: $startDate, endDate: $endDate, payrollMonth: $payrollMonth, payrollYear: $payrollYear, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeclarationPeriodDtoCopyWith<$Res> implements $DeclarationPeriodDtoCopyWith<$Res> {
  factory _$DeclarationPeriodDtoCopyWith(_DeclarationPeriodDto value, $Res Function(_DeclarationPeriodDto) _then) = __$DeclarationPeriodDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String tenantId, String? companyId, String periodType, int year, int? month, int? quarter, String startDate, String endDate, int? payrollMonth, int? payrollYear, String status, Map<String, Object?>? metadata, String createdAt, String updatedAt
});




}
/// @nodoc
class __$DeclarationPeriodDtoCopyWithImpl<$Res>
    implements _$DeclarationPeriodDtoCopyWith<$Res> {
  __$DeclarationPeriodDtoCopyWithImpl(this._self, this._then);

  final _DeclarationPeriodDto _self;
  final $Res Function(_DeclarationPeriodDto) _then;

/// Create a copy of DeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? companyId = freezed,Object? periodType = null,Object? year = null,Object? month = freezed,Object? quarter = freezed,Object? startDate = null,Object? endDate = null,Object? payrollMonth = freezed,Object? payrollYear = freezed,Object? status = null,Object? metadata = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DeclarationPeriodDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
