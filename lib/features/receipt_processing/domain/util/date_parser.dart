import 'package:injectable/injectable.dart';
import 'receipt_text_parser.dart';

/// Parser for extracting date from receipt OCR text
/// Supports various date formats: MM/DD/YYYY, DD-MM-YYYY, etc.
@injectable
class DateParser implements ReceiptTextParser<DateTime> {
  @override
  DateTime? parse(String text) {
    final datePattern = RegExp(r'(\d{1,2})[/-](\d{1,2})[/-](\d{2,4})');
    final match = datePattern.firstMatch(text);
    
    if (match != null) {
      try {
        int day = int.parse(match.group(1)!);
        int month = int.parse(match.group(2)!);
        int year = int.parse(match.group(3)!);

        // Adjust 2-digit year
        if (year < 100) {
          year += 2000;
        }

        return DateTime(year, month, day);
      } catch (exception) {
        // Invalid date
        return null;
      }
    }
    return null;
  }
}
