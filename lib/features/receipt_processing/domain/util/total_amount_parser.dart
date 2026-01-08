import 'package:injectable/injectable.dart';
import 'receipt_text_parser.dart';

/// Parser for extracting total amount from receipt OCR text
/// Implements multiple strategies to handle various receipt formats:
/// 1. Line-by-line search for TOTAL/SUMA keywords (handles Romanian receipts)
/// 2. Flexible pattern matching with currency symbols
/// 3. Fallback to largest amount found in text
@injectable
class TotalAmountParser implements ReceiptTextParser<double> {
  @override
  double? parse(String text) {
    // Strategy 1: Look for total label on same line with amount (handles Romanian format)
    // Matches patterns like:
    // "TOTAL: 45.50"
    // "Total: $12.34"
    // "TOTAL       123,45" (comma decimal separator)
    final lines = text.split('\n');
    for (final line in lines) {
      // Look for total keyword at start of line
      final totalLinePattern = RegExp(
        r'(?:total|suma|amount|subtotal|grand[\s_-]*total)[\s:]*(.+)',
        caseSensitive: false,
      );
      final lineMatch = totalLinePattern.firstMatch(line.trim());

      if (lineMatch != null) {
        final rightSide = lineMatch.group(1) ?? '';
        // Extract number from right side (handles spaces, currency symbols, comma/dot decimals)
        // More flexible pattern that captures various digit combinations
        final amountPattern = RegExp(r'[\$€£₹lei\s]*(\d+)[.,](\d{1,2})');
        final amountMatch = amountPattern.firstMatch(rightSide.trim());

        if (amountMatch != null) {
          final whole = amountMatch.group(1) ?? '0';
          var decimal = amountMatch.group(2) ?? '00';
          // Ensure decimal has 2 digits
          if (decimal.length == 1) decimal = '${decimal}0';
          return double.tryParse('$whole.$decimal');
        }
      }
    }

    // Strategy 2: Look for total keyword followed by amount with flexible spacing
    final totalPattern = RegExp(
      r'(?:total|suma|amount|subtotal)[\s:]+[\$€£₹lei\s]*(\d+)[.,](\d{1,2})',
      caseSensitive: false,
    );
    final match = totalPattern.firstMatch(text);
    if (match != null) {
      final whole = match.group(1) ?? '0';
      var decimal = match.group(2) ?? '00';
      if (decimal.length == 1) decimal = '${decimal}0';
      return double.tryParse('$whole.$decimal');
    }

    // Strategy 3: Fallback - find largest currency amount in text
    final amountPattern = RegExp(r'[\$€£₹]?\s*(\d+)[.,](\d{1,2})');
    final amounts = amountPattern.allMatches(text)
        .map((m) {
          final whole = m.group(1) ?? '0';
          var decimal = m.group(2) ?? '00';
          if (decimal.length == 1) decimal = '${decimal}0';
          return double.tryParse('$whole.$decimal');
        })
        .where((a) => a != null && a > 0)
        .cast<double>()
        .toList();

    if (amounts.isNotEmpty) {
      // Return the largest amount found
      amounts.sort((a, b) => b.compareTo(a));
      return amounts.first;
    }

    return null;
  }
}