import 'package:equatable/equatable.dart';
import '../../../../core/domain/month_year.dart';

class Receipt extends Equatable {
  final String id;
  final String imagePath;
  final String extractedText;
  final DateTime dateCaptured;
  final DateTime dateModified;
  final MonthYear monthYear;
  final String? merchantName;
  final double? totalAmount;
  final String? category;
  final String? notes;

  const Receipt({
    required this.id,
    required this.imagePath,
    required this.extractedText,
    required this.dateCaptured,
    required this.dateModified,
    required this.monthYear,
    this.merchantName,
    this.totalAmount,
    this.category,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        imagePath,
        extractedText,
        dateCaptured,
        dateModified,
        monthYear,
        merchantName,
        totalAmount,
        category,
        notes,
      ];

  Receipt copyWith({
    String? id,
    String? imagePath,
    String? extractedText,
    DateTime? dateCaptured,
    DateTime? dateModified,
    MonthYear? monthYear,
    String? merchantName,
    double? totalAmount,
    String? category,
    String? notes,
  }) {
    return Receipt(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      extractedText: extractedText ?? this.extractedText,
      dateCaptured: dateCaptured ?? this.dateCaptured,
      dateModified: dateModified ?? this.dateModified,
      monthYear: monthYear ?? this.monthYear,
      merchantName: merchantName ?? this.merchantName,
      totalAmount: totalAmount ?? this.totalAmount,
      category: category ?? this.category,
      notes: notes ?? this.notes,
    );
  }
}
