// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptModel {

 String get id; String get imagePath; String get extractedText; int get dateCaptured; int get dateModified; String get monthYear; String? get merchantName; double? get totalAmount; String? get category; String? get notes;
/// Create a copy of ReceiptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptModelCopyWith<ReceiptModel> get copyWith => _$ReceiptModelCopyWithImpl<ReceiptModel>(this as ReceiptModel, _$identity);

  /// Serializes this ReceiptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.extractedText, extractedText) || other.extractedText == extractedText)&&(identical(other.dateCaptured, dateCaptured) || other.dateCaptured == dateCaptured)&&(identical(other.dateModified, dateModified) || other.dateModified == dateModified)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,extractedText,dateCaptured,dateModified,monthYear,merchantName,totalAmount,category,notes);

@override
String toString() {
  return 'ReceiptModel(id: $id, imagePath: $imagePath, extractedText: $extractedText, dateCaptured: $dateCaptured, dateModified: $dateModified, monthYear: $monthYear, merchantName: $merchantName, totalAmount: $totalAmount, category: $category, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ReceiptModelCopyWith<$Res>  {
  factory $ReceiptModelCopyWith(ReceiptModel value, $Res Function(ReceiptModel) _then) = _$ReceiptModelCopyWithImpl;
@useResult
$Res call({
 String id, String imagePath, String extractedText, int dateCaptured, int dateModified, String monthYear, String? merchantName, double? totalAmount, String? category, String? notes
});




}
/// @nodoc
class _$ReceiptModelCopyWithImpl<$Res>
    implements $ReceiptModelCopyWith<$Res> {
  _$ReceiptModelCopyWithImpl(this._self, this._then);

  final ReceiptModel _self;
  final $Res Function(ReceiptModel) _then;

/// Create a copy of ReceiptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imagePath = null,Object? extractedText = null,Object? dateCaptured = null,Object? dateModified = null,Object? monthYear = null,Object? merchantName = freezed,Object? totalAmount = freezed,Object? category = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,extractedText: null == extractedText ? _self.extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as String,dateCaptured: null == dateCaptured ? _self.dateCaptured : dateCaptured // ignore: cast_nullable_to_non_nullable
as int,dateModified: null == dateModified ? _self.dateModified : dateModified // ignore: cast_nullable_to_non_nullable
as int,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiptModel].
extension ReceiptModelPatterns on ReceiptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiptModel value)  $default,){
final _that = this;
switch (_that) {
case _ReceiptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiptModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imagePath,  String extractedText,  int dateCaptured,  int dateModified,  String monthYear,  String? merchantName,  double? totalAmount,  String? category,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiptModel() when $default != null:
return $default(_that.id,_that.imagePath,_that.extractedText,_that.dateCaptured,_that.dateModified,_that.monthYear,_that.merchantName,_that.totalAmount,_that.category,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imagePath,  String extractedText,  int dateCaptured,  int dateModified,  String monthYear,  String? merchantName,  double? totalAmount,  String? category,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ReceiptModel():
return $default(_that.id,_that.imagePath,_that.extractedText,_that.dateCaptured,_that.dateModified,_that.monthYear,_that.merchantName,_that.totalAmount,_that.category,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imagePath,  String extractedText,  int dateCaptured,  int dateModified,  String monthYear,  String? merchantName,  double? totalAmount,  String? category,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ReceiptModel() when $default != null:
return $default(_that.id,_that.imagePath,_that.extractedText,_that.dateCaptured,_that.dateModified,_that.monthYear,_that.merchantName,_that.totalAmount,_that.category,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceiptModel extends ReceiptModel {
  const _ReceiptModel({required this.id, required this.imagePath, required this.extractedText, required this.dateCaptured, required this.dateModified, required this.monthYear, this.merchantName, this.totalAmount, this.category, this.notes}): super._();
  factory _ReceiptModel.fromJson(Map<String, dynamic> json) => _$ReceiptModelFromJson(json);

@override final  String id;
@override final  String imagePath;
@override final  String extractedText;
@override final  int dateCaptured;
@override final  int dateModified;
@override final  String monthYear;
@override final  String? merchantName;
@override final  double? totalAmount;
@override final  String? category;
@override final  String? notes;

/// Create a copy of ReceiptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptModelCopyWith<_ReceiptModel> get copyWith => __$ReceiptModelCopyWithImpl<_ReceiptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.extractedText, extractedText) || other.extractedText == extractedText)&&(identical(other.dateCaptured, dateCaptured) || other.dateCaptured == dateCaptured)&&(identical(other.dateModified, dateModified) || other.dateModified == dateModified)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,extractedText,dateCaptured,dateModified,monthYear,merchantName,totalAmount,category,notes);

@override
String toString() {
  return 'ReceiptModel(id: $id, imagePath: $imagePath, extractedText: $extractedText, dateCaptured: $dateCaptured, dateModified: $dateModified, monthYear: $monthYear, merchantName: $merchantName, totalAmount: $totalAmount, category: $category, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ReceiptModelCopyWith<$Res> implements $ReceiptModelCopyWith<$Res> {
  factory _$ReceiptModelCopyWith(_ReceiptModel value, $Res Function(_ReceiptModel) _then) = __$ReceiptModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String imagePath, String extractedText, int dateCaptured, int dateModified, String monthYear, String? merchantName, double? totalAmount, String? category, String? notes
});




}
/// @nodoc
class __$ReceiptModelCopyWithImpl<$Res>
    implements _$ReceiptModelCopyWith<$Res> {
  __$ReceiptModelCopyWithImpl(this._self, this._then);

  final _ReceiptModel _self;
  final $Res Function(_ReceiptModel) _then;

/// Create a copy of ReceiptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imagePath = null,Object? extractedText = null,Object? dateCaptured = null,Object? dateModified = null,Object? monthYear = null,Object? merchantName = freezed,Object? totalAmount = freezed,Object? category = freezed,Object? notes = freezed,}) {
  return _then(_ReceiptModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,extractedText: null == extractedText ? _self.extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as String,dateCaptured: null == dateCaptured ? _self.dateCaptured : dateCaptured // ignore: cast_nullable_to_non_nullable
as int,dateModified: null == dateModified ? _self.dateModified : dateModified // ignore: cast_nullable_to_non_nullable
as int,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
