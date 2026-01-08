import 'package:equatable/equatable.dart';
import '../../../../core/domain/month_year.dart';

class SharePackage extends Equatable {
  final String pdfPath;
  final MonthYear monthYear;
  final int receiptCount;
  final DateTime generatedAt;

  const SharePackage({
    required this.pdfPath,
    required this.monthYear,
    required this.receiptCount,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [pdfPath, monthYear, receiptCount, generatedAt];
}
