// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_declaration_period_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateDeclarationPeriodDto {

 String? get companyId; String get periodType; int get year; int? get month; int? get quarter; String get startDate; String get endDate; int? get payrollMonth; int? get payrollYear; Map<String, Object?>? get metadata;
/// Create a copy of CreateDeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDeclarationPeriodDtoCopyWith<CreateDeclarationPeriodDto> get copyWith => _$CreateDeclarationPeriodDtoCopyWithImpl<CreateDeclarationPeriodDto>(this as CreateDeclarationPeriodDto, _$identity);

  /// Serializes this CreateDeclarationPeriodDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDeclarationPeriodDto&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyId,periodType,year,month,quarter,startDate,endDate,payrollMonth,payrollYear,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'CreateDeclarationPeriodDto(companyId: $companyId, periodType: $periodType, year: $year, month: $month, quarter: $quarter, startDate: $startDate, endDate: $endDate, payrollMonth: $payrollMonth, payrollYear: $payrollYear, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $CreateDeclarationPeriodDtoCopyWith<$Res>  {
  factory $CreateDeclarationPeriodDtoCopyWith(CreateDeclarationPeriodDto value, $Res Function(CreateDeclarationPeriodDto) _then) = _$CreateDeclarationPeriodDtoCopyWithImpl;
@useResult
$Res call({
 String? companyId, String periodType, int year, int? month, int? quarter, String startDate, String endDate, int? payrollMonth, int? payrollYear, Map<String, Object?>? metadata
});




}
/// @nodoc
class _$CreateDeclarationPeriodDtoCopyWithImpl<$Res>
    implements $CreateDeclarationPeriodDtoCopyWith<$Res> {
  _$CreateDeclarationPeriodDtoCopyWithImpl(this._self, this._then);

  final CreateDeclarationPeriodDto _self;
  final $Res Function(CreateDeclarationPeriodDto) _then;

/// Create a copy of CreateDeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyId = freezed,Object? periodType = null,Object? year = null,Object? month = freezed,Object? quarter = freezed,Object? startDate = null,Object? endDate = null,Object? payrollMonth = freezed,Object? payrollYear = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDeclarationPeriodDto].
extension CreateDeclarationPeriodDtoPatterns on CreateDeclarationPeriodDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDeclarationPeriodDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDeclarationPeriodDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDeclarationPeriodDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  Map<String, Object?>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto() when $default != null:
return $default(_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  Map<String, Object?>? metadata)  $default,) {final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto():
return $default(_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? companyId,  String periodType,  int year,  int? month,  int? quarter,  String startDate,  String endDate,  int? payrollMonth,  int? payrollYear,  Map<String, Object?>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _CreateDeclarationPeriodDto() when $default != null:
return $default(_that.companyId,_that.periodType,_that.year,_that.month,_that.quarter,_that.startDate,_that.endDate,_that.payrollMonth,_that.payrollYear,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateDeclarationPeriodDto implements CreateDeclarationPeriodDto {
  const _CreateDeclarationPeriodDto({this.companyId, required this.periodType, required this.year, this.month, this.quarter, required this.startDate, required this.endDate, this.payrollMonth, this.payrollYear, final  Map<String, Object?>? metadata}): _metadata = metadata;
  factory _CreateDeclarationPeriodDto.fromJson(Map<String, dynamic> json) => _$CreateDeclarationPeriodDtoFromJson(json);

@override final  String? companyId;
@override final  String periodType;
@override final  int year;
@override final  int? month;
@override final  int? quarter;
@override final  String startDate;
@override final  String endDate;
@override final  int? payrollMonth;
@override final  int? payrollYear;
 final  Map<String, Object?>? _metadata;
@override Map<String, Object?>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of CreateDeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDeclarationPeriodDtoCopyWith<_CreateDeclarationPeriodDto> get copyWith => __$CreateDeclarationPeriodDtoCopyWithImpl<_CreateDeclarationPeriodDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDeclarationPeriodDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDeclarationPeriodDto&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyId,periodType,year,month,quarter,startDate,endDate,payrollMonth,payrollYear,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'CreateDeclarationPeriodDto(companyId: $companyId, periodType: $periodType, year: $year, month: $month, quarter: $quarter, startDate: $startDate, endDate: $endDate, payrollMonth: $payrollMonth, payrollYear: $payrollYear, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$CreateDeclarationPeriodDtoCopyWith<$Res> implements $CreateDeclarationPeriodDtoCopyWith<$Res> {
  factory _$CreateDeclarationPeriodDtoCopyWith(_CreateDeclarationPeriodDto value, $Res Function(_CreateDeclarationPeriodDto) _then) = __$CreateDeclarationPeriodDtoCopyWithImpl;
@override @useResult
$Res call({
 String? companyId, String periodType, int year, int? month, int? quarter, String startDate, String endDate, int? payrollMonth, int? payrollYear, Map<String, Object?>? metadata
});




}
/// @nodoc
class __$CreateDeclarationPeriodDtoCopyWithImpl<$Res>
    implements _$CreateDeclarationPeriodDtoCopyWith<$Res> {
  __$CreateDeclarationPeriodDtoCopyWithImpl(this._self, this._then);

  final _CreateDeclarationPeriodDto _self;
  final $Res Function(_CreateDeclarationPeriodDto) _then;

/// Create a copy of CreateDeclarationPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyId = freezed,Object? periodType = null,Object? year = null,Object? month = freezed,Object? quarter = freezed,Object? startDate = null,Object? endDate = null,Object? payrollMonth = freezed,Object? payrollYear = freezed,Object? metadata = freezed,}) {
  return _then(_CreateDeclarationPeriodDto(
companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}


}

// dart format on
