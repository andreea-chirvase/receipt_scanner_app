import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/database_constants.dart';
import '../../../../core/domain/month_year.dart';
import '../../domain/model/receipt.dart';

part 'receipt_model.freezed.dart';
part 'receipt_model.g.dart';

@freezed
abstract class ReceiptModel with _$ReceiptModel {
  const ReceiptModel._();

  const factory ReceiptModel({
    required String id,
    required String imagePath,
    required String extractedText,
    required int dateCaptured,
    required int dateModified,
    required String monthYear,
    String? merchantName,
    double? totalAmount,
    String? category,
    String? notes,
  }) = _ReceiptModel;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);
}

extension ReceiptModelX on ReceiptModel {
  Receipt toDomain() {
    return Receipt(
      id: id,
      imagePath: imagePath,
      extractedText: extractedText,
      dateCaptured: DateTime.fromMillisecondsSinceEpoch(dateCaptured),
      dateModified: DateTime.fromMillisecondsSinceEpoch(dateModified),
      monthYear: MonthYear.parse(monthYear),
      merchantName: merchantName,
      totalAmount: totalAmount,
      category: category,
      notes: notes,
    );
  }

  static ReceiptModel fromDomain(Receipt receipt) {
    return ReceiptModel(
      id: receipt.id,
      imagePath: receipt.imagePath,
      extractedText: receipt.extractedText,
      dateCaptured: receipt.dateCaptured.millisecondsSinceEpoch,
      dateModified: receipt.dateModified.millisecondsSinceEpoch,
      monthYear: receipt.monthYear.toIsoString(),
      merchantName: receipt.merchantName,
      totalAmount: receipt.totalAmount,
      category: receipt.category,
      notes: receipt.notes,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      DatabaseConstants.columnId: id,
      DatabaseConstants.columnImagePath: imagePath,
      DatabaseConstants.columnExtractedText: extractedText,
      DatabaseConstants.columnDateCaptured: dateCaptured,
      DatabaseConstants.columnDateModified: dateModified,
      DatabaseConstants.columnMonthYear: monthYear,
      DatabaseConstants.columnMerchantName: merchantName,
      DatabaseConstants.columnTotalAmount: totalAmount,
      DatabaseConstants.columnCategory: category,
      DatabaseConstants.columnNotes: notes,
    };
  }

  static ReceiptModel fromDatabase(Map<String, dynamic> map) {
    return ReceiptModel(
      id: map[DatabaseConstants.columnId] as String,
      imagePath: map[DatabaseConstants.columnImagePath] as String,
      extractedText: map[DatabaseConstants.columnExtractedText] as String,
      dateCaptured: map[DatabaseConstants.columnDateCaptured] as int,
      dateModified: map[DatabaseConstants.columnDateModified] as int,
      monthYear: map[DatabaseConstants.columnMonthYear] as String,
      merchantName: map[DatabaseConstants.columnMerchantName] as String?,
      totalAmount: map[DatabaseConstants.columnTotalAmount] as double?,
      category: map[DatabaseConstants.columnCategory] as String?,
      notes: map[DatabaseConstants.columnNotes] as String?,
    );
  }
}
