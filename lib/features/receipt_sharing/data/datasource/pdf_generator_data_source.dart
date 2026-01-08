import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/exceptions.dart';
import '../../../receipt_storage/domain/model/receipt.dart';

abstract class PdfGeneratorDataSource {
  Future<String> generatePdf(MonthYear monthYear, List<Receipt> receipts);
}

@LazySingleton(as: PdfGeneratorDataSource)
class PdfGeneratorDataSourceImpl implements PdfGeneratorDataSource {
  @override
  Future<String> generatePdf(MonthYear monthYear, List<Receipt> receipts) async {
    try {
      final title = '${monthYear.toDisplayString()} Receipts';

      final pdf = pw.Document(
        title: title,
      );

      // Add receipt images one after another
      for (final receipt in receipts) {
        await _addReceiptImagePage(pdf, receipt);
      }

      // Save PDF to temporary directory
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'receipts_${monthYear.toIsoString()}_$timestamp.pdf';
      final filePath = path.join(directory.path, fileName);

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      return filePath;
    } catch (e) {
      throw StorageException('Failed to generate PDF: $e');
    }
  }

  Future<void> _addReceiptImagePage(
    pw.Document pdf,
    Receipt receipt,
  ) async {
    // Load receipt image
    try {
      final imageFile = File(receipt.imagePath);
      if (await imageFile.exists()) {
        final imageBytes = await imageFile.readAsBytes();
        final imageProvider = pw.MemoryImage(imageBytes);

        // Add a page with just the receipt image, filling the entire page
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Center(
                child: pw.Image(
                  imageProvider,
                  fit: pw.BoxFit.contain,
                ),
              );
            },
          ),
        );
      }
    } catch (e) {
      // If image fails to load, skip this receipt
      return;
    }
  }
}
