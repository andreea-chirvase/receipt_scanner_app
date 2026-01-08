import 'package:injectable/injectable.dart';
import 'receipt_text_parser.dart';

/// Parser for extracting merchant name from receipt OCR text
/// Simply extracts the first non-empty line
@injectable
class MerchantNameParser implements ReceiptTextParser<String> {
  @override
  String? parse(String text) {
    final lines = text.split('\n').where((line) => line.trim().isNotEmpty).toList();
    
    if (lines.isNotEmpty) {
      return lines.first.trim();
    }
    return null;
  }
}