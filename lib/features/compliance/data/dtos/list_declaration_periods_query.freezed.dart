// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_declaration_periods_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListDeclarationPeriodsQueryDto {

 String? get companyId; String? get periodType; String? get status; int? get year; int? get month; int? get quarter; int? get payrollMonth; int? get payrollYear;
/// Create a copy of ListDeclarationPeriodsQueryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListDeclarationPeriodsQueryDtoCopyWith<ListDeclarationPeriodsQueryDto> get copyWith => _$ListDeclarationPeriodsQueryDtoCopyWithImpl<ListDeclarationPeriodsQueryDto>(this as ListDeclarationPeriodsQueryDto, _$identity);

  /// Serializes this ListDeclarationPeriodsQueryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListDeclarationPeriodsQueryDto&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.status, status) || other.status == status)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyId,periodType,status,year,month,quarter,payrollMonth,payrollYear);

@override
String toString() {
  return 'ListDeclarationPeriodsQueryDto(companyId: $companyId, periodType: $periodType, status: $status, year: $year, month: $month, quarter: $quarter, payrollMonth: $payrollMonth, payrollYear: $payrollYear)';
}


}

/// @nodoc
abstract mixin class $ListDeclarationPeriodsQueryDtoCopyWith<$Res>  {
  factory $ListDeclarationPeriodsQueryDtoCopyWith(ListDeclarationPeriodsQueryDto value, $Res Function(ListDeclarationPeriodsQueryDto) _then) = _$ListDeclarationPeriodsQueryDtoCopyWithImpl;
@useResult
$Res call({
 String? companyId, String? periodType, String? status, int? year, int? month, int? quarter, int? payrollMonth, int? payrollYear
});




}
/// @nodoc
class _$ListDeclarationPeriodsQueryDtoCopyWithImpl<$Res>
    implements $ListDeclarationPeriodsQueryDtoCopyWith<$Res> {
  _$ListDeclarationPeriodsQueryDtoCopyWithImpl(this._self, this._then);

  final ListDeclarationPeriodsQueryDto _self;
  final $Res Function(ListDeclarationPeriodsQueryDto) _then;

/// Create a copy of ListDeclarationPeriodsQueryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyId = freezed,Object? periodType = freezed,Object? status = freezed,Object? year = freezed,Object? month = freezed,Object? quarter = freezed,Object? payrollMonth = freezed,Object? payrollYear = freezed,}) {
  return _then(_self.copyWith(
companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: freezed == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListDeclarationPeriodsQueryDto].
extension ListDeclarationPeriodsQueryDtoPatterns on ListDeclarationPeriodsQueryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListDeclarationPeriodsQueryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListDeclarationPeriodsQueryDto value)  $default,){
final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListDeclarationPeriodsQueryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? companyId,  String? periodType,  String? status,  int? year,  int? month,  int? quarter,  int? payrollMonth,  int? payrollYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto() when $default != null:
return $default(_that.companyId,_that.periodType,_that.status,_that.year,_that.month,_that.quarter,_that.payrollMonth,_that.payrollYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? companyId,  String? periodType,  String? status,  int? year,  int? month,  int? quarter,  int? payrollMonth,  int? payrollYear)  $default,) {final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto():
return $default(_that.companyId,_that.periodType,_that.status,_that.year,_that.month,_that.quarter,_that.payrollMonth,_that.payrollYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? companyId,  String? periodType,  String? status,  int? year,  int? month,  int? quarter,  int? payrollMonth,  int? payrollYear)?  $default,) {final _that = this;
switch (_that) {
case _ListDeclarationPeriodsQueryDto() when $default != null:
return $default(_that.companyId,_that.periodType,_that.status,_that.year,_that.month,_that.quarter,_that.payrollMonth,_that.payrollYear);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListDeclarationPeriodsQueryDto implements ListDeclarationPeriodsQueryDto {
  const _ListDeclarationPeriodsQueryDto({this.companyId, this.periodType, this.status, this.year, this.month, this.quarter, this.payrollMonth, this.payrollYear});
  factory _ListDeclarationPeriodsQueryDto.fromJson(Map<String, dynamic> json) => _$ListDeclarationPeriodsQueryDtoFromJson(json);

@override final  String? companyId;
@override final  String? periodType;
@override final  String? status;
@override final  int? year;
@override final  int? month;
@override final  int? quarter;
@override final  int? payrollMonth;
@override final  int? payrollYear;

/// Create a copy of ListDeclarationPeriodsQueryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListDeclarationPeriodsQueryDtoCopyWith<_ListDeclarationPeriodsQueryDto> get copyWith => __$ListDeclarationPeriodsQueryDtoCopyWithImpl<_ListDeclarationPeriodsQueryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListDeclarationPeriodsQueryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListDeclarationPeriodsQueryDto&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.status, status) || other.status == status)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.quarter, quarter) || other.quarter == quarter)&&(identical(other.payrollMonth, payrollMonth) || other.payrollMonth == payrollMonth)&&(identical(other.payrollYear, payrollYear) || other.payrollYear == payrollYear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyId,periodType,status,year,month,quarter,payrollMonth,payrollYear);

@override
String toString() {
  return 'ListDeclarationPeriodsQueryDto(companyId: $companyId, periodType: $periodType, status: $status, year: $year, month: $month, quarter: $quarter, payrollMonth: $payrollMonth, payrollYear: $payrollYear)';
}


}

/// @nodoc
abstract mixin class _$ListDeclarationPeriodsQueryDtoCopyWith<$Res> implements $ListDeclarationPeriodsQueryDtoCopyWith<$Res> {
  factory _$ListDeclarationPeriodsQueryDtoCopyWith(_ListDeclarationPeriodsQueryDto value, $Res Function(_ListDeclarationPeriodsQueryDto) _then) = __$ListDeclarationPeriodsQueryDtoCopyWithImpl;
@override @useResult
$Res call({
 String? companyId, String? periodType, String? status, int? year, int? month, int? quarter, int? payrollMonth, int? payrollYear
});




}
/// @nodoc
class __$ListDeclarationPeriodsQueryDtoCopyWithImpl<$Res>
    implements _$ListDeclarationPeriodsQueryDtoCopyWith<$Res> {
  __$ListDeclarationPeriodsQueryDtoCopyWithImpl(this._self, this._then);

  final _ListDeclarationPeriodsQueryDto _self;
  final $Res Function(_ListDeclarationPeriodsQueryDto) _then;

/// Create a copy of ListDeclarationPeriodsQueryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyId = freezed,Object? periodType = freezed,Object? status = freezed,Object? year = freezed,Object? month = freezed,Object? quarter = freezed,Object? payrollMonth = freezed,Object? payrollYear = freezed,}) {
  return _then(_ListDeclarationPeriodsQueryDto(
companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,periodType: freezed == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,quarter: freezed == quarter ? _self.quarter : quarter // ignore: cast_nullable_to_non_nullable
as int?,payrollMonth: freezed == payrollMonth ? _self.payrollMonth : payrollMonth // ignore: cast_nullable_to_non_nullable
as int?,payrollYear: freezed == payrollYear ? _self.payrollYear : payrollYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
