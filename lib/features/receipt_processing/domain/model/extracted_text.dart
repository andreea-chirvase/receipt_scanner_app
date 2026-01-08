import 'package:equatable/equatable.dart';

class ExtractedText extends Equatable {
  final String text;
  final String? merchantName;
  final double? totalAmount;
  final DateTime? date;

  const ExtractedText({
    required this.text,
    this.merchantName,
    this.totalAmount,
    this.date,
  });

  @override
  List<Object?> get props => [text, merchantName, totalAmount, date];
}
