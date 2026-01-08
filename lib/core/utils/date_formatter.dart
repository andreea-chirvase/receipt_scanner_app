import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class DateFormatter {
  static String formatFullDate(DateTime date) {
    return DateFormat(AppConstants.dateFormatFull).format(date);
  }

  static String formatMonth(DateTime date) {
    return DateFormat(AppConstants.dateFormatMonth).format(date);
  }

  static String formatMonthYear(DateTime date) {
    return DateFormat(AppConstants.dateFormatMonthYear).format(date);
  }

  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return formatFullDate(date);
    }
  }

  static DateTime parseMonthYear(String monthYear) {
    return DateFormat(AppConstants.dateFormatMonthYear).parse(monthYear);
  }

  static String getCurrentMonthYear() {
    return formatMonthYear(DateTime.now());
  }

  static List<String> getLastMonths(int count) {
    final result = <String>[];
    final now = DateTime.now();

    for (int i = 0; i < count; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      result.add(formatMonthYear(date));
    }

    return result;
  }

  static String getMonthName(String monthYear) {
    final date = parseMonthYear(monthYear);
    return DateFormat('MMM').format(date);
  }
}
