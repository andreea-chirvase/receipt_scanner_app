import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/exceptions.dart';

abstract class ShareDataSource {
  Future<void> sharePdf(String pdfPath, MonthYear monthYear);
}

@LazySingleton(as: ShareDataSource)
class ShareDataSourceImpl implements ShareDataSource {
  @override
  Future<void> sharePdf(String pdfPath, MonthYear monthYear) async {
    try {
      final file = File(pdfPath);
      if (!await file.exists()) {
        throw StorageException('PDF file not found: $pdfPath');
      }

      final monthYearDisplay = monthYear.toDisplayString();
      final result = await Share.shareXFiles(
        [XFile(pdfPath)],
        subject: 'Receipts - $monthYearDisplay',
        text: 'Here are my receipts for $monthYearDisplay',
      );

      if (result.status == ShareResultStatus.unavailable) {
        throw StorageException('Sharing is not available on this device');
      }
    } catch (e) {
      if (e is StorageException) rethrow;
      throw StorageException('Failed to share PDF: $e');
    }
  }
}
