// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) =>
    _ReceiptModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      extractedText: json['extractedText'] as String,
      dateCaptured: (json['dateCaptured'] as num).toInt(),
      dateModified: (json['dateModified'] as num).toInt(),
      monthYear: json['monthYear'] as String,
      merchantName: json['merchantName'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      category: json['category'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ReceiptModelToJson(_ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'extractedText': instance.extractedText,
      'dateCaptured': instance.dateCaptured,
      'dateModified': instance.dateModified,
      'monthYear': instance.monthYear,
      'merchantName': instance.merchantName,
      'totalAmount': instance.totalAmount,
      'category': instance.category,
      'notes': instance.notes,
    };
